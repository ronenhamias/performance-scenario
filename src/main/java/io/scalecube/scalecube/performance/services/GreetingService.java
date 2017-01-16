package io.scalecube.scalecube.performance.services;

import io.scalecube.services.annotations.Service;
import io.scalecube.services.annotations.ServiceMethod;

import java.util.concurrent.CompletableFuture;

@Service
public interface GreetingService {

  @ServiceMethod
  CompletableFuture<String> greeting(String string);

}
