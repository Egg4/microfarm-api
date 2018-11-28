<?php

namespace App;

abstract class FactoryTest
{
    public static function getContainer()
    {
        static $container;

        if (!$container) {
            $container = new \Egg\Container();
            $container['environment'] = \Egg\Http\Environment::create([
                'APP_ENV'   => APP_ENV,
                'APP_DEBUG' => APP_DEBUG,
            ]);
            registerServices($container);
            registerComponents($container);

            $container['cache'] = function($container) {
                return new \Egg\Cache\Memory($container['config']['cache']);
            };
        }

        return $container;
    }

    public static function getClient()
    {
        static $client;

        if (!$client) {
            $client = new \Egg\Http\Client(self::getContainer(), [
                'Accept'        => 'application/json',
                'Content-Type'  => 'application/json',
            ]);
        }

        return $client;
    }

    public static function login($data)
    {
        $client = self::getClient();
        $content = $client->post('/v1.0/user/login', [], [
            'email'     => $data['email'],
            'password'  => $data['password'],
        ]);

        if (isset($content['key'])) {
            $client->setHeader('Authorization', $content['key']);
        }

        return $content;
    }

    public static function logout()
    {
        $client = self::getClient();
        $content = $client->post('/v1.0/user/logout');
        $client->removeHeader('Authorization');

        return $content;
    }

    public static function authenticate($data)
    {
        $client = self::getClient();
        $content = $client->post('/v1.0/user_role/authenticate', [], [
            'id'    => $data['id'],
        ]);

        return $content;
    }
}