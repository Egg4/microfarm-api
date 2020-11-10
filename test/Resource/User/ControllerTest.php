<?php
namespace App\Resource\User;

use App\FactoryTest;

class ControllerTest extends \PHPUnit\Framework\TestCase
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
        FactoryTest::login([
            'email'     => $this->user->email,
            'password'  => $password,
        ]);
    }

    public function tearDown(): void
    {
        $this->container['database']->rollback();
    }

    public function testSelectShouldRaiseExceptionNotAllowed()
    {
        $content = $this->client->get('/v1.0/user?range=0-10');

        $this->assertEquals(403, $this->client->getResponse()->getStatusCode());
        $this->assertEquals('not_allowed', $content[0]['name']);
    }

    /*
    public function testReadShouldRaiseExceptionNotAllowed()
    {
        $content = $this->client->get(sprintf('/v1.0/user/%s', $this->user->id));

        $this->assertEquals(403, $this->client->getResponse()->getStatusCode());
        $this->assertEquals('not_allowed', $content[0]['name']);
    }

    public function testCreateShouldRaiseExceptionNotAllowed()
    {
        $content = $this->client->post('/v1.0/user');

        $this->assertEquals(403, $this->client->getResponse()->getStatusCode());
        $this->assertEquals('not_allowed', $content[0]['name']);
    }

    public function testUpdateShouldRaiseExceptionNotAllowed()
    {
        $content = $this->client->patch(sprintf('/v1.0/user/%s', $this->user->id));

        $this->assertEquals(403, $this->client->getResponse()->getStatusCode());
        $this->assertEquals('not_allowed', $content[0]['name']);
    }

    public function testReplaceShouldRaiseExceptionNotAllowed()
    {
        $content = $this->client->put(sprintf('/v1.0/user/%s', $this->user->id));

        $this->assertEquals(403, $this->client->getResponse()->getStatusCode());
        $this->assertEquals('not_allowed', $content[0]['name']);
    }

    public function testDeleteShouldRaiseExceptionNotAllowed()
    {
        $content = $this->client->delete(sprintf('/v1.0/user/%s', $this->user->id));

        $this->assertEquals(403, $this->client->getResponse()->getStatusCode());
        $this->assertEquals('not_allowed', $content[0]['name']);
    }
    */
}