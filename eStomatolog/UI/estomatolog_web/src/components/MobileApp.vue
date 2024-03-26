<template>
  <div class="mobile-app">
    <img src="../assets/footer.png" alt="Footer slika" class="footer-image">
  </div>
</template>

<script>
export default {
  name: 'MobileApp',
}
</script>

<style scoped>
.mobile-app {
  position: relative;
  width: 100%; 
  height: 100%; 
  overflow: hidden; 
  margin-top: 200px;
}

.mobile-app::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  filter: blur(4px);
  z-index: -1;
}

.footer-image {
  width: 90%; 
  padding: 20px; 
  margin: auto; 
  box-shadow: 0 100px 200px rgba(0, 0, 0, 0.1); 
}
</style>
