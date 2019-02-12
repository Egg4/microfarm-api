<?php

namespace App;

class Authorizer extends \Egg\Authorizer\Generic
{
    protected function analyse($action)
    {
        $authentication = $this->container['request']->getAttribute('authentication');

        return $this->isUserAuthenticated($authentication)
            ? $this->analyseUserAuthenticated($authentication, $action)
            : [];
    }

    protected function isUserAuthenticated($authentication)
    {
        return is_array($authentication)
        AND array_key_exists('user_id', $authentication);
    }

    protected function isUserRoleAuthenticated($authentication)
    {
        return is_array($authentication)
        AND array_key_exists('entity_id', $authentication)
        AND array_key_exists('role_id', $authentication);
    }

    protected function analyseUserAuthenticated($authentication, $action)
    {
        if ($this->resource == 'user' AND $action == 'logout') {
            return [];
        }

        if (in_array($this->resource, ['family', 'genus', 'species', 'plant', 'category'])
            AND $action == 'select') {
            return [];
        }

        $userRoleRepository = $this->container['repository']['user_role'];
        $userRoles = $userRoleRepository->selectAll(['user_id' => $authentication['user_id']]);
        if ($this->resource == 'entity' AND $action == 'select') {
            return [
                'id' => $userRoles->toArray('entity_id'),
            ];
        }
        if ($this->resource == 'user_role' AND in_array($action, ['select', 'authenticate'])) {
            return [
                'id' => $userRoles->toArray('id'),
            ];
        }
        if ($this->resource == 'role' AND $action == 'select') {
            return [
                'entity_id' => $userRoles->toArray('entity_id'),
            ];
        }

        if ($this->isUserRoleAuthenticated($authentication)) {
            return $this->analyseUserRoleAuthenticated($authentication, $action);
        }

        throw new \Egg\Http\Exception($this->container['response'], 403, new \Egg\Http\Error(array(
            'name'          => 'not_allowed',
            'description'   => sprintf('"%s %s" access denied', $this->resource, $action),
        )));
    }

    protected function analyseUserRoleAuthenticated($authentication, $action)
    {
        if ($this->resource == 'entity' AND $action == 'all') {
            return [];
        }

        // Admin user
        if (is_null($authentication['role_id'])) {
            return $this->analyseAdminAccess($authentication, $action);
        }
        // Not admin user
        else {
            return $this->analyseRoleAccess($authentication, $action);
        }
    }

    protected function analyseAdminAccess($authentication, $action)
    {
        if ($this->resource == 'user' AND $action == 'select') {
            return [];
        }

        return [
            'entity_id' => $authentication['entity_id'],
        ];
    }

    protected function analyseRoleAccess($authentication, $action)
    {
        $roleAccessRepository = $this->container['repository']['role_access'];
        $roleAccess = $roleAccessRepository->selectOne([
            'entity_id' => $authentication['entity_id'],
            'role_id'   => $authentication['role_id'],
            'resource'  => $this->resource,
        ]);

        if ($roleAccess
            AND isset($roleAccess->$action)
            AND $roleAccess->$action === true
        ) {
            return [
                'entity_id' => $authentication['entity_id'],
            ];
        }

        throw new \Egg\Http\Exception($this->container['response'], 403, new \Egg\Http\Error(array(
            'name'          => 'not_allowed',
            'description'   => sprintf('"%s %s" access denied', $this->resource, $action),
        )));
    }
}