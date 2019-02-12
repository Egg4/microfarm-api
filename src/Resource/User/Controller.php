<?php

namespace App\Resource\User;

class Controller extends \Egg\Controller\Generic
{
    public function signup(array $params)
    {
        $hashPassword = $this->container['password']['hash'];
        $params['password'] = $hashPassword($params['password']);
        $timeout = $this->container['config']['signup']['timeout'];
        $key = $this->container['authenticator']->create($params, $timeout);

        return [
            'key'       => $key,
            'timeout'   => $timeout,
        ];
    }

    public function activate(array $params)
    {
        $data = $this->container['authenticator']->get($params['key']);
        $id = $this->repository->insert($data);
        $user = $this->repository->selectOneById($id);
        $serializer = $this->container['serializer'][$this->resource];

        return $serializer->serialize($user);
    }

    public function login(array $params)
    {
        $entity = $this->repository->selectOneByEmail($params['email']);

        $authData = [
            'user_id' => $entity->id,
        ];
        $timeout = $this->container['config']['authentication']['timeout'];
        $key = $this->container['authenticator']->create($authData, $timeout);

        return array_merge($authData, [
            'key'       => $key,
            'timeout'   => $timeout,
        ]);
    }

    public function defer()
    {
        $authData = $this->container['request']->getAttribute('authentication');
        $timeout = $this->container['config']['authentication']['timeout'];
        $key = $this->container['authenticator']->create($authData, $timeout);

        return [
            'key'       => $key,
            'timeout'   => $timeout,
        ];
    }
}