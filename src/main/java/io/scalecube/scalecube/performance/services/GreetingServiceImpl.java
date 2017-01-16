package io.scalecube.scalecube.performance.services;

import java.util.concurrent.CompletableFuture;

public class GreetingServiceImpl implements GreetingService {

  @Override
  public CompletableFuture<String> greeting(String name) {
    return CompletableFuture.completedFuture("Hello " + name);
  }

}
