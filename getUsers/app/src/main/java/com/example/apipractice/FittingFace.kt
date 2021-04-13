package com.example.apipractice

import retrofit2.Call
import retrofit2.http.GET

interface FittingFace {
    @GET("/users")
    fun fetchUsers(): Call<List<User>>
}