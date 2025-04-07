package com.musician.api.configuration;

import com.musician.api.response.ApiResponse;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

import java.util.Map;

@ControllerAdvice
public class GlobalApiResponseWrapper implements ResponseBodyAdvice<Object> {

    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        return true;
    }

    @Override
    public Object beforeBodyWrite(
            Object body,
            MethodParameter returnType,
            MediaType selectedContentType,
            Class<? extends HttpMessageConverter<?>> selectedConverterType,
            org.springframework.http.server.ServerHttpRequest request,
            org.springframework.http.server.ServerHttpResponse response
    ) {
        // Ne pas re-wrap si c'est déjà une réponse bien formée
        if (body instanceof Map && ((Map<?, ?>) body).containsKey("data")) {
            return body;
        }

        // Déduire automatiquement le type depuis le nom du contrôleur (ex: UserResponse -> "users")
        String inferredType = inferTypeFromReturnType(returnType);

        ApiResponse<Object> wrapped = new ApiResponse<>(inferredType, body);
        return Map.of("data", wrapped);
    }

    private String inferTypeFromReturnType(MethodParameter returnType) {
        // objectif : "UserResponse" => "users"
        String className = returnType.getParameterType().getSimpleName().toLowerCase();

        if (className.endsWith("response")) {
            className = className.replace("response", "");
        }
        return className + "s";
    }
}