module PhotoGroove exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

-- helper function
urlPrefix = 
  "http://elm-in-action.com/"

{-
  the view returns Html markup. by passign the model we connect the "state"
  of the application with the markup.
-}
view model =
  div [ class "content" ]
    [ h1 [] [ text "Photo Groove" ]
    , div [ id "thumbnails" ] 
      (List.map (viewThumbnail model.selectedUrl) model.photos)
    , img 
      [ class "large"
      , src (urlPrefix ++ "large/" ++ model.selectedUrl)
      ]
      []
    ]

{-
  helper function, which renders a single thumbnail as Html
  Partially Applied function (curried)
-}
viewThumbnail selectedUrl thumb = 
  img 
    [ src (urlPrefix ++ thumb.url) 
    , classList [ ( "selected", selectedUrl == thumb.url ) ]
    , onClick { description = "ClickedPhoto", data = thumb.url }
    ]
    []
  


initialModel = 
  { photos = 
    [ { url= "1.jpeg" }
    , { url= "2.jpeg" }
    , { url= "3.jpeg" }
    ]
  , selectedUrl = "1.jpeg"
  }

{-
  hooks up our view to the model "state"
-}
update msg model = 
  if msg.description == "ClickedPhoto" then
    { model | selectedUrl = msg.data }  
  else 
    model

main = 
  Browser.sandbox
    { init = initialModel
    , view = view
    , update = update
    }
