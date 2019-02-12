<?php
namespace App\Resource\User;

use App\FactoryTest;

class SignupTest extends \PHPUnit\Framework\TestCase
{
    public function setUp()
    {
        $this->container = FactoryTest::getContainer();
        $this->client = FactoryTest::getClient();
        $this->container['database']->beginTransaction();

        $this->user1 = $this->container['factory']['user']->create([
            'email'     => 'email123@fai.fr',
            'password'  => 'Password123',
        ]);
    }

    public function tearDown()
    {
        $this->container['database']->rollback();
    }

    public function testShouldRaiseExceptionNotUnique()
    {
        $response = $this->client->post('/v1.0/user/signup', [], [
            'first_name'    => 'James',
            'last_name'     => 'Green',
            'email'         => $this->user1->email,
            'password'      => 'Password123',
        ]);

        $this->assertEquals(400, $this->client->getResponse()->getStatusCode());
        $this->assertEquals('not_unique', $response[0]['name']);
    }

    public function testShouldSignup()
    {
        $userData = [
            'first_name'    => 'James',
            'last_name'     => 'Green',
            'email'         => 'james.green@fai.fr',
            'password'      => 'Password123',
        ];

        // Assert getting signup key
        $response = $this->client->post('/v1.0/user/signup', [], $userData);
        $this->assertEquals(200, $this->client->getResponse()->getStatusCode());
        $signupKey = $response['key'];
        $this->assertEquals(true, strlen($signupKey) > 0);

        // Assert user is not in db
        $user = $this->container['repository']['user']->selectOne(['email' => $userData['email']]);
        $this->assertEquals(false, $user);

        // Assert wrong key is rejected
        $response = $this->client->post('/v1.0/user/activate', [], ['key' => 'wrong_key']);
        $this->assertEquals(404, $this->client->getResponse()->getStatusCode());
        $this->assertEquals('not_found', $response[0]['name']);

        // Assert activate user
        $response = $this->client->post('/v1.0/user/activate', [], ['key' => $signupKey]);
        $this->assertEquals(200, $this->client->getResponse()->getStatusCode());
        $this->assertEquals(true, $response['id'] > 0);
        $this->assertEquals($userData['email'], $response['email']);

        // Assert user is in db
        $user = $this->container['repository']['user']->selectOne(['email' => $userData['email']]);
        $this->assertEquals($userData['email'], $user->email);
    }
}