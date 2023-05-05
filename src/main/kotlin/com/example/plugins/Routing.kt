package com.example.plugins

import io.ktor.http.*
import io.ktor.server.routing.*
import io.ktor.server.response.*
import io.ktor.server.application.*

data class UserData(val name: String, val age: Int, val email: String)


fun Application.configureRouting() {

    routing {
        get("/") {
            call.respondText("Hello World!", ContentType.Text.Plain)
        }

        get("/health") {
            call.respondText("I'm healthy!")
        }
    }
}
