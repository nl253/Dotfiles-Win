import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")
}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    //add custom config here, such as

    "ui.colorscheme": "nord",

    //"oni.useDefaultConfig": true,
    //"oni.bookmarks": ["~/Documents"],
    //"oni.loadInitVim": false,
    "editor.fontSize": "17px",
    //"editor.fontFamily": "Monaco",

    // UI customizations
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",
}
