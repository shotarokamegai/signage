
do ->

  Video = require "./Video"
  Ad = require "./Ad"
  Signage = require "./Signage"

  movies = [
    "http://pdl.vimeocdn.com/02014/089/230012081.mp4?token2=1425872474_7564e65b8552e17db3a943c26d5b8d39"
    "https://avvimeo-a.akamaihd.net/40223/653/137113021.mp4?token2=1425872704_827890d526908dc4b866926a3e510810"
  ]

  ads = [
    "http://c4.staticflickr.com/8/7286/16129131004_20f558be87_k.jpg"
    "http://c4.staticflickr.com/8/7605/16747512421_27180963a6_h.jpg"
  ]

  data = [
    new Video("#video", movies)
    new Ad("#ad", ads)
  ]

  # player dydnamic control
  order = [1, 0]

  s = new Signage(data, order)
  s.start()


