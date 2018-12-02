<?php

namespace App;

class Authorizer extends \Egg\Authorizer\Generic
{
    protected function analyse($action)
    {
        return $this->isUserAuthenticated() ?
            $this->analyseUserAuthenticated($action) :
            $this->analyseUserNotAuthenticated($action);
    }

    protected function isUserAuthenticated()
    {
        $authentication = $this->container['request']->getAttribute('authentication');
        return isset($authentication['user']);
    }

    protected function isUserRoleAuthenticated()
    {
        $authentication = $this->container['request']->getAttribute('authentication');
        return isset($authentication['user_role']);
    }

    protected function analyseUserNotAuthenticated($action)
    {
        if ($this->resource == 'user' AND $action == 'login') {
            return [];
        }

        throw new \Egg\Http\Exception($this->container['response'], 403, new \Egg\Http\Error(array(
            'name'          => 'authentication_required',
            'description'   => 'Authentication is required',
        )));
    }

    protected function analyseUserAuthenticated($action)
    {
        $authentication = $this->container['request']->getAttribute('authentication');

        if ($this->resource == 'user' AND $action == 'logout') {
            return [];
        }

        if (in_array($this->resource, ['family', 'genus', 'species', 'plant', 'category'])
            AND $action == 'select') {
            return [];
        }

        if ($this->resource == 'entity' AND $action == 'select') {
            $userRoleRepository = $this->container['repository']['user_role'];
            $entities = $userRoleRepository->selectAll(['user_id' => $authentication['user']['id']]);
            return [
                'id' => $entities->toArray('entity_id'),
            ];
        }

        if ($this->resource == 'user_role' AND in_array($action, ['select', 'authenticate'])) {
            $userRoleRepository = $this->container['repository']['user_role'];
            $entities = $userRoleRepository->selectAll(['user_id' => $authentication['user']['id']]);
            return [
                'entity_id' => $entities->toArray('entity_id'),
            ];
        }

        if ($this->isUserRoleAuthenticated()) {
            return $this->analyseUserRoleAuthenticated($action);
        }

        throw new \Egg\Http\Exception($this->container['response'], 403, new \Egg\Http\Error(array(
            'name'          => 'not_allowed',
            'description'   => sprintf('"%s %s" access denied', $this->resource, $action),
        )));
    }

    protected function analyseUserRoleAuthenticated($action)
    {
        $authentication = $this->container['request']->getAttribute('authentication');

        if (is_null($authentication['user_role']['role_id'])) {
            return [
                'entity_id' => $authentication['user_role']['entity_id'],
            ];
        }

        throw new \Egg\Http\Exception($this->container['response'], 403, new \Egg\Http\Error(array(
            'name'          => 'not_allowed',
            'description'   => sprintf('"%s %s" access denied', $this->resource, $action),
        )));
    }
}