package com.example.sharedpreferencespractice.util

import android.content.Context
import com.example.sharedpreferencespractice.model.Item

class prefsData {

    fun saveDataSharedPrefs(itemList: ArrayList<Item>, context: Context) {
        //get access to a shared preferences file
        val sharedPrefs = context.getSharedPreferences("SHARED_PREF", Context.MODE_PRIVATE)
        //create an editor to write to the shared preferences file
        val editor = sharedPrefs.edit()
        //add size to the editor
        for ((index, item) in itemList.withIndex()){
            editor.putString("Name", item.name)
        }
        //save the data
        editor.apply()
    }

    fun loadDataSharedPrefs(context: Context):ArrayList<Item>{
        var loadedItemList = ArrayList<Item>()
        //get access to a shared preferences file
        val sharedPrefs = context.getSharedPreferences("SHARED_PREF", Context.MODE_PRIVATE)

        loadedItemList.add(Item(sharedPrefs.getString("Name", "")!!))
        loadedItemList.add(Item(sharedPrefs.getString("Cookie", "")!!))

        return loadedItemList
    }
}