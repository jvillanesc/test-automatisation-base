function fn() {
    var config = {
        baseUrl: 'http://localhost:8080/testuser/api',
        basePath: '/characters'
    };

    // Configuración global
    karate.configure('ssl', true);

    return config;
}