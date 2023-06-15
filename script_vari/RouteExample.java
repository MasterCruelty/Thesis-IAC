// OK
package com.certimeter.interviewtool.gateway;

//_______________________________________________________________________________________________________________________________

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.reactive.CorsWebFilter;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;


//_______________________________________________________________________________________________________________________________

@Configuration
public class AppConfig {

    //___________________________________________________________________________________________________________________________
    
    @Bean
    public RouteLocator router(RouteLocatorBuilder route_builder) {

        return(

            route_builder.routes()

                .route("path_route", r -> r.path("/user/**")
                    .and()
                    .method("POST", "GET", "PATCH", "DELETE")
                    .uri("http://user-service.interview-tool.svc.cluster.local:8080"))

                .route("path_route", r -> r.path("/template/**")
                    .and()
                    .method("POST", "GET", "PATCH", "DELETE")
                    .uri("http://template-service.interview-tool.svc.cluster.local:8081"))

                .route("path_route", r -> r.path("/question/**")
                    .and()
                    .method("POST", "GET", "PATCH", "DELETE")
                    .uri("http://question-service.interview-tool.svc.cluster.local:8082"))

                .route("path_route", r -> r.path("/quiz/**")
                    .and()
                    .method("POST", "GET", "PATCH", "DELETE")
                    .uri("http://quiz-service.interview-tool.svc.cluster.local:8083"))
                
            .build()
        );
    }

    @Bean
    public CorsWebFilter corsConfiguration() {

        CorsConfiguration cors_configuration = new CorsConfiguration();
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();

        cors_configuration.applyPermitDefaultValues();
        cors_configuration.addAllowedMethod("PATCH");
        cors_configuration.addAllowedMethod("DELETE");
        cors_configuration.addAllowedMethod("OPTIONS");
        source.registerCorsConfiguration("/**", cors_configuration);

        return(new CorsWebFilter(source));
    }

    //___________________________________________________________________________________________________________________________
}
