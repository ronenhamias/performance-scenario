package scalecube

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._

class BasicSimulation extends Simulation {

    io.scalecube.scalecube.performance.App.main(null)
   	
	val scn = scenario("scalecube-greeting").repeat(500, "count") { 
		exec(http("greeting").get("http://localhost:8080/do"))
	}

	setUp(scn.inject(rampUsers(6000) over (180 seconds)))

}