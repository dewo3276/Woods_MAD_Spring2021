package com.example.sharedpreferencespractice.model

import android.app.Application
import android.util.Log
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.AndroidViewModel
import com.example.sharedpreferencespractice.util.prefsData

class ItemViewModel(application: Application) : AndroidViewModel(application){
    val itemList = MutableLiveData<ArrayList<Item>>()
    private var newList = ArrayList<Item>()
    val context = application.applicationContext
    val sharedPrefsData = prefsData()

    fun add(item: Item){
        newList.add(item)
        itemList.value = newList
    }

    fun delete(item: Item){
        newList.remove(item)
        itemList.value = newList
    }

    fun loadData(){
        newList = sharedPrefsData.loadDataSharedPrefs(context)
        itemList.value = newList
        Log.i("vm load", itemList.value!!.size.toString())
    }

    fun saveData(){
        itemList.value?.let{sharedPrefsData.saveDataSharedPrefs(itemList.value!!, context)}
    }
}