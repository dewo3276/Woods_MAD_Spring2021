package com.example.memesrus.defaultDAta

import com.example.memesrus.R
import com.example.memesrus.model.meme

object sampleData {
    val memeListNew = ArrayList<meme>()

    val memeListOld = ArrayList<meme>()

    init {
        memeListNew.add(meme(name = "bernie", R.drawable.bernie))
        memeListNew.add(meme(name = "yellatcat", R.drawable.yellatcat))
        memeListNew.add(meme(name = "yoda", R.drawable.yoda))
        memeListNew.add(meme(name = "isthis", R.drawable.isthis))
    }

    init {
        memeListOld.add(meme(name = "wat", R.drawable.wat))
        memeListOld.add(meme(name = "whyyouno", R.drawable.whyyouno))
        memeListOld.add(meme(name = "ermergerd", R.drawable.ermergerd))
        memeListOld.add(meme(name = "troll", R.drawable.troll))
    }
}