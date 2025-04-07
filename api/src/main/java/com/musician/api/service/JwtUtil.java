package com.musician.api.service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import jakarta.annotation.PostConstruct;
import java.security.Key;
import java.util.Date;
import java.util.function.Function;
import javax.crypto.SecretKey;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class JwtUtil {
  @Value("${jwt.secret}")
  private String secret;

  @Value("${jwt.expiration}")
  private long expiration;

  private Key key;

  @PostConstruct
  public void init() {
    // Si la clé n'est pas en Base64, nous la convertissons d'abord en Base64
    // puis utilisons un décodeur pour obtenir le tableau d'octets
    byte[] keyBytes = Decoders.BASE64.decode(secret);
    key = Keys.hmacShaKeyFor(keyBytes);
  }

  public String generateToken(String subject) {
    return Jwts.builder()
        .subject(subject)
        .issuedAt(new Date(System.currentTimeMillis()))
        .expiration(new Date(System.currentTimeMillis() + expiration))
        .signWith(key)
        .compact();
  }

  public boolean isTokenValid(String token, String expectedSubject) {
    try {
      String subject = extractSubject(token);
      return (subject.equals(expectedSubject) && !isTokenExpired(token));
    } catch (Exception e) {
      return false;
    }
  }

  public String extractSubject(String token) {
    return extractClaim(token, Claims::getSubject);
  }

  public String extractUsername(String token) {
    return extractSubject(token);
  }

  public boolean validateToken(String token, String username) {
    return isTokenValid(token, username);
  }

  private Date extractExpiration(String token) {
    return extractClaim(token, Claims::getExpiration);
  }

  private <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
    final Claims claims = extractAllClaims(token);
    return claimsResolver.apply(claims);
  }

  private Claims extractAllClaims(String token) {
    return Jwts.parser().verifyWith((SecretKey) key).build().parseSignedClaims(token).getPayload();
  }

  private boolean isTokenExpired(String token) {
    return extractExpiration(token).before(new Date());
  }
}
