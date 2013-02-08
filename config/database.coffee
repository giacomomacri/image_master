module.exports = 
  development:
    driver: "mongodb"
    url: "mongodb://localhost/image_master"

  test:
    driver: "memory"

  production:
    driver: "memory"
