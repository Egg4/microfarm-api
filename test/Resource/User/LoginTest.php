<?php
namespace App\Resource\User;

use App\FactoryTest;

class LoginTest extends \PHPUnit\Framework\TestCase
{
    public function setUp()
    {
        $this->container = FactoryTest::getContainer();
        $this->client = FactoryTest::getClient();
        $this->container['database']->beginTransaction();

        $this->user = $this->container['factory']['user']->create([
            'password'  => 'Password123',
        ]);
    }

    public function tearDown()
    {
        $this->container['database']->rollback();
    }

    public function testLoginShouldRaiseExceptionAuthenticationFailure()
    {
        $content = FactoryTest::login([
            'email'     => $this->user->email,
            'password'  => 'BadPassword123',
        ]);

        $this->assertEquals(403, $this->client->getResponse()->getStatusCode());
        $this->assertEquals('authentication_failure', $content[0]['name']);
    }

    public function testLoginShouldSucceed()
    {
        $content = FactoryTest::login([
            'email'     => $this->user->email,
            'password'  => 'Password123',
        ]);

        $this->assertEquals(200, $this->client->getResponse()->getStatusCode());
        $this->assertEquals($this->user->email, $content['user']['email']);
        $this->assertEquals(32, strlen($content['key']));
        $this->assertEquals(false, isset($content['user']['password']));
    }
}