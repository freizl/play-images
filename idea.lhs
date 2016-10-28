# Server

> module Main where
>
> {- detail design of server side -}
>
>
> -- define an threadhold for each client
> -- so that it will not cause too much load to server
> -- like 50 per 2 hours
> rate = 50
>
>
> -- upload image and preview the crop / resize image
> -- URI /upload
> upload = do
>   blockAnyNoneBrowserRequest
>   uniqId <- uniqIdFromRequest
>   if exceedUploadRate uniqId then error 401 "you create too many requests"
>   image <- getFileFromRequest
>   if exceedUploadSizeLimit image then error 401 "file is too big for uploading"
>   size <- sizeFromRequest
>   if not (validateSize image size) then error 401 "input size is not valid"
>   croppedImage <- cropImage image size
>   return croppedImage
>
>
> -- FIXME: need further enhancement given size could be inch,cm etc
> --        but image size is always by pixel
> --
> validateSize size image =
>   let w = width image
>       y = height image
>   in
>     (width size <= w) && (height size <= y)
>

> -- Base on the crop / resize image, generate print-able photo
> -- URI /generate
> generate = do
>   uniqId <- uniqIdFromRequest
>   if exceedGenerateRate uniqId then error 401 "you create too many requests"
>   file <- getFileFromRequest
>   if exceedGenerateSizeLimit file then error 401 "file is too big for generating"
>
>
>
> -- FIXME: how?
> -- 1. bot has default none-browser header (also phantomjs). good to use
> -- 2. what if they modify header? use ip ?
> -- 3. what if diverce IPs?
> -- 4. what if selenium automation?
> -- 5. MAC address??
> -- 6 . an normal human flow would take N seconds per request,
> --    if intensity is too high, they are suspicious requests
> blockAnyNoneBrowserRequest = undefined
>
> -- FIXME: what will be good way?
> --        1. is MAC address available from request?
> --        2. event yes, what if they fake MAC address?
> --
> uniqIdFromRequest = undefined
>


# Open Question

1. need user management (signup/signin) flow?
