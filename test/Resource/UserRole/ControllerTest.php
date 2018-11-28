<?php
namespace App\Resource\UserRole;

use App\FactoryTest;

class ControllerTest extends \PHPUnit\Framework\TestCase
{
    public function setUp()
    {
        $this->container = FactoryTest::getContainer();
        $this->client = FactoryTest::getClient();
        $this->container['database']->beginTransaction();

        $password = 'Aa123456';
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

    public function tearDown()
    {
        FactoryTest::logout();
        $this->container['database']->rollback();
    }

    public function testAuthenticateShouldRaiseNotFoundException()
    {
        $content = FactoryTest::authenticate([
            'id' => 0,
        ]);

        $this->assertEquals(403, $this->client->getResponse()->getStatusCode());
        $this->assertEquals('not_allowed', $content[0]['name']);
    }

    public function testAuthenticateShouldSucceed()
    {
        $content = FactoryTest::authenticate([
            'id' => $this->userRole->id,
        ]);

        $this->assertEquals(200, $this->client->getResponse()->getStatusCode());
        $this->assertEquals($this->user->id, $content['user_role']['user_id']);
    }
}