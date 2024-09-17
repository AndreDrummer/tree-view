# Tractian Challenge - Tree View App

A new Flutter project designed to render companies' assets disposition in a tree view structure interface.

The difference here is that the app does not use ANY external library but nevertheless values the performance and user experience.

## Table of Contents

- [Presenting Video](#presenting-video)
- [Screenshots](#screenshots)
- [Next steps](#next-steps)


## Presenting Video

<div align="center">
  <a href="https://www.youtube.com/watch?v=0psuA54bVgQ" target="_blank">
    <img src="https://img.youtube.com/vi/0psuA54bVgQ/hqdefault.jpg" alt="Watch the video" width="560"/>
  </a>
  <p><strong>Building a Custom Tree View for Asset Management | Mobile Software Engineer Challenge</strong></p>
</div>



## Screenshots

<table>
  <tr>
    <td align="center" colspan="4">Splashscreen</td>
  </tr>
  <tr>
    <td align="center" colspan="4">Loading states</td>
  </tr>
  <tr>
    <td><img src="screenshots/splash-wait.png" alt="Splashscreen" width="200"/></td>
    <td><img src="screenshots/splash-lets-get-started.png" alt="Splashscreen" width="200"/></td>
    <td><img src="screenshots/splash-is-great.png" alt="Splashscreen" width="200"/></td>
    <td><img src="screenshots/splash-continue.png" alt="Splashscreen" width="200"/></td>
  </tr>
  <tr>
    <td align="center" colspan="4">Error states</td>
  </tr>
  <tr>    
    <td align="center"><img src="screenshots/connection-error.jpeg" alt="Splashscreen" width="200"/></td>
    <td align="center"><img src="screenshots/server-error.jpeg" alt="Splashscreen" width="200"/></td>
    <td align="center"><img src="screenshots/unexpected-error.jpeg" alt="Splashscreen" width="200"/></td>           
    <td align="center"><img src="screenshots/unexpected-error.jpeg" alt="Splashscreen" width="200"/></td>           
  </tr>
</table>

<table>
  <tr>
    <td align="center" colspan="4">Home</td>
  </tr>
  <tr>
    <td align="center" colspan="4">Company List Screen</td>
  </tr>
  <tr>
    <td><img src="screenshots/home-light.jpeg" alt="Splashscreen" width="200"/></td>
    <td><img src="screenshots/error-home-light.jpeg" alt="Splashscreen" width="200"/></td>
    <td><img src="screenshots/home-dark.jpeg" alt="Splashscreen" width="200"/></td>
    <td><img src="screenshots/error-home-dark.jpeg" alt="Splashscreen" width="200"/></td>  
  </tr> 
</table>

<table>
  <tr>
    <td align="center" colspan="4">Assets View</td>
  </tr>
  <tr>
    <td align="center" colspan="4">Light Mode</td>
  </tr>
  <tr>
    <td><img src="screenshots/no-filter-light.jpeg" alt="Splashscreen" width="200"/></td>
    <td><img src="screenshots/energy-filter-light.jpeg" alt="Splashscreen" width="200"/></td>
    <td><img src="screenshots/critical-filter-light.jpeg" alt="Splashscreen" width="200"/></td>
    <td><img src="screenshots/text-filter-light.jpeg" alt="Splashscreen" width="200"/></td>  
  </tr> 
  <tr>
    <td align="center" colspan="4">Dark Mode</td>
  </tr>
  <tr>
    <td><img src="screenshots/no-filter-dark.jpeg" alt="Splashscreen" width="200"/></td>
    <td><img src="screenshots/energy-filter-dark.jpeg" alt="Splashscreen" width="200"/></td>
    <td><img src="screenshots/critical-filter-dark.jpeg" alt="Splashscreen" width="200"/></td>
    <td><img src="screenshots/text-filter-dark.jpeg" alt="Splashscreen" width="200"/></td>  
  </tr> 
</table>


## Next Steps

#### Caching Mechanisim

It would be great to have a mechanism to cache the downloaded company data to live during a pre-established time. Today, the time to pull down this data is not a problem, but it would allow the offline use of the app.

#### Better management device connection state

For simplicity, this project poorly handles the HTTP states. It can sharpened by manipulating the state of the device's internet connection so that when it doesn't have a connection, not even try to pull data.

#### Testings Overall

Until the date of publishing, this project does not have any piece of testing code of kind unity or integration.