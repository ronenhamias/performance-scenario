package scalecube

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._

class BasicSimulation extends Simulation {

    io.scalecube.scalecube.performance.App.main(null)
   	
	val scn = scenario("scalecube-greeting").repeat(50, "count") { 
		exec(http("greeting").get("http://localhost:8080/do"))
	}

	setUp(scn.inject(rampUsers(5000) over (180 seconds)))

}