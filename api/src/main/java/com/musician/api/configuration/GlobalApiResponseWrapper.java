package com.musician.api.configuration;

import com.musician.api.response.ApiResponse;
import com.musician.api.response.LoginResponse;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

@ControllerAdvice
public class GlobalApiResponseWrapper implements ResponseBodyAdvice<Object> {
  private final List<Class<?>> excludedTypes = Arrays.asList(LoginResponse.class);

  @Override
  public boolean supports(
      MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
    return true;
  }

  @Override
  public Object beforeBodyWrite(
      Object body,
      MethodParameter returnType,
      MediaType selectedContentType,
      Class<? extends HttpMessageConverter<?>> selectedConverterType,
      org.springframework.http.server.ServerHttpRequest request,
      org.springframework.http.server.ServerHttpResponse response) {

    // Ne pas re-wrapper si déjà dans "data" ou est dans la liste d'exclusion
    if (isAlreadyWrapped(body) || shouldSkipWrapping(body)) {
      return body;
    }

    // Ne pas wrapper si réponse d'erreur (status 4xx/5xx)
    int status =
        response.getHeaders().getFirst("status") != null
            ? Integer.parseInt(response.getHeaders().getFirst("status"))
            : 200;

    if (status >= 400) return body;

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

  private boolean isAlreadyWrapped(Object body) {
    if (body instanceof Map<?, ?> map) {
      return map.containsKey("data") || map.containsKey("error") || map.containsKey("errors");
    }

    return false;
  }

  private boolean shouldSkipWrapping(Object body) {
    return excludedTypes.stream().anyMatch(type -> type.isInstance(body));
  }
}
