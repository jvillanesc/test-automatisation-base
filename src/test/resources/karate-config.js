function fn() {
    var config = {
        port_bp_dev_test: 'http://localhost:8080/testuser/api',
        basePath: '/characters'
    };

    // Configuración global
    karate.configure('ssl', true);

    return config;
}