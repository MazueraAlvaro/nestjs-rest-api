module.exports = {
    apps: [
        {
            name: "products-api",
            script: "npm start",
            watch: true,
            env: {
                APP_PORT: 8080,
                NODE_ENV: "production"
            }
        }
    ]
}
