!function(window, document){
  window.GoogleAnalyticsObject = 'ga'
  window.ga = {
    l: +new Date(),
    q: [['create', 'UA-34997099-2', 'fengb.info'], ['send', 'pageview']]
  }

  var newTag = document.createElement('script')
  newTag.async = 1
  newTag.src = '//www.google-analytics.com/analytics.js'
  var loadedTag = document.getElementsByTagName('script')[0]
  loadedTag.parentNode.insertBefore(newTag, loadedTag)
}(window, document)
