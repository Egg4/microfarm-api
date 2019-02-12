<?php

namespace App\Resource\UserRole;

class Controller extends \Egg\Controller\Generic
{
    public function authenticate(array $params)
    {
        $userRole = $this->repository->selectOneById($params['id']);

        $authData = $this->container['request']->getAttribute('authentication');
        $authData = array_merge($authData, [
            'entity_id' => $userRole->entity_id,
            'role_id'   => $userRole->role_id,
        ]);
        $timeout = $this->container['config']['authentication']['timeout'];
        $key = $this->container['authenticator']->create($authData, $timeout);

        return array_merge($authData, [
            'key'       => $key,
            'timeout'   => $timeout,
        ]);
    }
}