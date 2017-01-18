package io.scalecube.scalecube.performance;

import io.scalecube.scalecube.performance.services.GreetingService;
import io.scalecube.scalecube.performance.services.GreetingServiceImpl;
import io.scalecube.services.Microservices;

import org.rapidoid.io.IO;
import org.rapidoid.setup.On;

public class App {

  public static void main(String[] args) {
    System.out.println("service starting...");
    Microservices gateway = Microservices.builder().build();

    Microservices provider = Microservices.builder()
        .seeds(gateway.cluster().address())
        .services(new GreetingServiceImpl())
        .build();

    GreetingService service = gateway.proxy().api(GreetingService.class).create();
    On.port(8080).route("GET", "/do").plain(req -> {
      req.async();
      service.greeting("hello").whenComplete((resp, error) -> {
        if(error== null){
          IO.write(req.response().out(), "reply :" + resp);
          req.done();
        }else{
          IO.write(req.response().out(), "sorry:" +error.getMessage());
          req.done();
        }
      });
      return req;
    });
    System.out.println("service started.");     
  }
  
  
}
