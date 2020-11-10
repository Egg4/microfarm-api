<?php
namespace App\Resource\UserRole;

use App\FactoryTest;

class AuthenticateTest extends \PHPUnit\Framework\TestCase
{
    public function setUp(): void
    {
        $this->container = FactoryTest::getContainer();
        $this->client = FactoryTest::getClient();
        $this->container['database']->beginTransaction();

        $password = 'Password123';
        $this->user = $this->container['factory']['user']->create([
            'password'  => $password,
        ]);
        $this->userRole = $this->container['factory']['user_role']->create([
            'user_id'   => $this->user->id,
        ]);
        FactoryTest::login([
            'email'     => $this->user->email,
            'password'  => $password,
        ]);
    }

    public function tearDown(): void
    {
        $this->container['database']->rollback();
    }

    public function testShouldRaiseNotAllowedException()
    {
        $response = FactoryTest::authenticate([
            'id' => 0,
        ]);

        $this->assertEquals(403, $this->client->getResponse()->getStatusCode());
        $this->assertEquals('not_allowed', $response[0]['name']);
    }

    public function testShouldSucceed()
    {
        $response = FactoryTest::authenticate([
            'id' => $this->userRole->id,
        ]);

        $this->assertEquals(200, $this->client->getResponse()->getStatusCode());
        $this->assertEquals($this->userRole->entity_id, $response['entity_id']);
        $this->assertEquals($this->userRole->user_id, $response['user_id']);
        $this->assertEquals($this->userRole->role_id, $response['role_id']);
    }
}