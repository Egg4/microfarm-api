<?php

namespace App;

class Authorizer extends \Egg\Authorizer\AbstractAuthorizer
{
    protected $container;
    protected $resource;

    public function __construct(array $settings = [])
    {
        parent::__construct(array_merge([
            'container'     => null,
            'resource'      => null,
        ], $settings));

        $this->container = $this->settings['container'];
        $this->resource = $this->settings['resource'];
    }

    protected function analyse($action)
    {
        if ($this->resource == 'user' AND in_array($action, ['login', 'logout'])) {
            return [];
        }

        $authentication = $this->container['request']->getAttribute('authentication');
        if (!$authentication) {
            throw new \Egg\Http\Exception($this->container['response'], 403, new \Egg\Http\Error(array(
                'name'          => 'authentication_required',
                'description'   => 'Authentication is required',
            )));
        }

        if ($this->resource == 'user_role' AND in_array($action, ['authenticate'])) {
            $userRoleRepository = $this->container['repository']['user_role'];
            $entities = $userRoleRepository->selectAll(['user_id' => $authentication['user']['id']]);
            return [
                'id' => $entities->toArray('id'),
            ];
        }

        if (!is_null($authentication['user_role']['role_id'])) {
            throw new \Egg\Http\Exception($this->container['response'], 403, new \Egg\Http\Error(array(
                'name'          => 'not_allowed',
                'description'   => sprintf('"%s %s" access denied', $this->resource, $action),
            )));
        }

        return [
            'entity_id' => $authentication['user_role']['entity_id'],
        ];
    }

    public function __call($action, $arguments)
    {
        $params = isset($arguments[0]) ? $arguments[0] : [];
        $filterParams = $this->analyse($action);
        if (!empty($filterParams)) {
            $this->checkParams($params, $filterParams);
            $this->checkEntityExists(array_merge($params, $filterParams));
        }
    }

    protected function checkParams($params, $filterParams)
    {
        foreach($filterParams as $key => $value) {
            if (!in_array($key, array_keys($params))) {
                continue;
            }
            if (is_array($value)
                AND in_array($params[$key], $value)
                OR $value == $params[$key]
            ) {
                continue;
            }
            throw new \Egg\Http\Exception($this->container['response'], 403, new \Egg\Http\Error(array(
                'name'          => 'not_allowed',
                'description'   => 'Access denied',
            )));
        }
    }

    protected function checkEntityExists($params)
    {
        $repository = $this->container['repository'][$this->resource];
        $entity = $repository->selectOne($params);
        if (!$entity) {
            throw new \Egg\Http\Exception($this->container['response'], 403, new \Egg\Http\Error(array(
                'name'          => 'not_allowed',
                'description'   => 'Access denied',
            )));
        }
    }
}