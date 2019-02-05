<?php

namespace App\Resource\User;

class Controller extends \Egg\Controller\Generic
{
    public function signup(array $params)
    {
        $key = \Egg\Yolk\Rand::alphanum(18);
        $hashPassword = $this->container['password']['hash'];
        $params['password'] = $hashPassword($params['password']);
        $ttl = $this->container['config']['signup']['timeout'];
        $this->container['cache']->set($key, $params, $ttl);

        return [
            'key' => $key,
        ];
    }

    public function activate(array $params)
    {
        $cache = $this->container['cache'];
        $key = $params['key'];
        $data = $cache->get($key);
        $cache->delete($key);
        $id = $this->repository->insert($data);
        $entity = $this->repository->selectOneById($id);
        $serializer = $this->container['serializer'][$this->resource];

        return $serializer->serialize($entity);
    }

    public function login(array $params)
    {
        $entity = $this->repository->selectOneByEmail($params['email']);
        $serializer = $this->container['serializer'][$this->resource];
        $data[$this->resource] = $serializer->serialize($entity);
        $authentication = $this->container['authenticator']->create($data);

        return $authentication;
    }

    public function logout()
    {
        $authentication = $this->container['request']->getAttribute('authentication');
        $this->container['authenticator']->delete($authentication['key']);
    }
}