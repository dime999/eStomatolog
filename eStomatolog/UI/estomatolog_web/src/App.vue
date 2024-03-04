<template>
  <div id="app">
    <Bodysection />
    <div id="ordinacije-bar-container">
  <OrdinacijeBar />
</div>
  </div>
</template>

<script>
import Bodysection from './components/Bodysection.vue'
import OrdinacijeBar from './components/Ordinacije.vue'

export default {
  name: 'App',
  components: {
    Bodysection,
    OrdinacijeBar
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap');
#app {
  font-family: 'Roboto', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

#app::before {
  content: "";
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: url('../public/background.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  filter: blur(4px); 
  z-index: -1; 
}
</style>
