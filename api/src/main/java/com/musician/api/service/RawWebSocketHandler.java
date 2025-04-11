package com.musician.api.service;

import jakarta.websocket.*;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import org.springframework.stereotype.Component;

@ServerEndpoint("/ws/conversations/{conversationId}")
@Component
public class RawWebSocketHandler {

  // conversationId -> sessions
  private static final Map<String, Set<Session>> conversationSessions = new ConcurrentHashMap<>();

  @OnOpen
  public void onOpen(Session session, @PathParam("conversationId") String conversationId) {
    conversationSessions
        .computeIfAbsent(conversationId, k -> ConcurrentHashMap.newKeySet())
        .add(session);
    System.out.println("✅ Client connecté a la conversation " + conversationId);
  }

  @OnClose
  public void onClose(Session session, @PathParam("conversationId") String conversationId) {
    Set<Session> sessions = conversationSessions.get(conversationId);
    if (sessions != null) {
      sessions.remove(session);
      System.out.println("⚠️ Client déconnecté a la conversation " + conversationId);
    }
  }

  @OnError
  public void onError(Session session, Throwable throwable) {
    System.err.println(
        "❌ Erreur WebSocket sur session " + session.getId() + ": " + throwable.getMessage());
  }

  @OnMessage
  public void onMessage(String message, @PathParam("conversationId") String conversationId) {}

  public static void broadcastToChannel(String conversationId, String message) {
    Set<Session> sessions = conversationSessions.get(conversationId);

    if (sessions != null) {
      for (Session session : sessions) {
        System.out.println("broadcasting to :" + session);

        try {
          session.getBasicRemote().sendText(message);
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
    }
  }
}
