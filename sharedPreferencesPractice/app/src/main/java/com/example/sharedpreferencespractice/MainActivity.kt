package com.example.sharedpreferencespractice

import android.content.Context
import android.content.SharedPreferences
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.view.menu.MenuView
import com.example.sharedpreferencespractice.model.ItemViewModel
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        loadData()

        logCookie.setOnClickListener{
            saveData()
        }
    }

    private fun saveData(){
        val name: String = nameTextEdit.text.toString()
        val cookie: String = cookieTextEdit.text.toString()

        val sharedPreferences = getSharedPreferences("SHARED_PREF", Context.MODE_PRIVATE)
        val editor = sharedPreferences.edit()

        editor.apply {
            putString("Name", name)
            putString("Cookie", cookie)
        }.apply()

        Toast.makeText(this, "cookie preferences have been saved", Toast.LENGTH_LONG).show()
        nameText.text=name
        cookieText.text=cookie
    }

    private fun loadData(){
        val prefs = getSharedPreferences("SHARED_PREF", Context.MODE_PRIVATE)
        nameText.text=prefs.getString("Name", "")
        cookieText.text=prefs.getString("Cookie","")
    }
}