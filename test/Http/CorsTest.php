<?php
namespace App\Http;

use App\FactoryTest;

class CorsTest extends \PHPUnit\Framework\TestCase
{
    public function setUp()
    {
        $this->container = FactoryTest::getContainer();
        $this->client = FactoryTest::getClient();
    }

    public function testShouldAllowOrigin()
    {
        $origin = 'https://www.mysite.com';
        $requestHeaders = [
            'Access-Control-Request-Headers'    => 'content-type',
            'Access-Control-Request-Method'     => 'POST',
            'Origin'                            => $origin,
        ];

        $this->client->options('/v1.0/user/login', $requestHeaders, []);
        $response = $this->client->getResponse();
        $this->assertEquals(200, $response->getStatusCode());
        $responseHeaders = $response->getHeaders();
        $this->assertEquals($origin, $responseHeaders['Access-Control-Allow-Origin'][0]);
        $this->assertEquals(0, $responseHeaders['Content-Length'][0]);
    }
}