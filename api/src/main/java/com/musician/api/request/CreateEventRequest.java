package com.musician.api.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;
import java.util.List;
import lombok.Getter;

@Getter
public class CreateEventRequest {
  @JsonProperty("name")
  @NotBlank(message = "Event name is required")
  private String name;

  @JsonProperty("start_date")
  @NotNull(message = "Start date is required")
  @FutureOrPresent(message = "Start date must be in the present or future")
  private LocalDate startDate;

  @JsonProperty("end_date")
  @NotNull(message = "End date is required")
  @FutureOrPresent(message = "End date must be in the present or future")
  private LocalDate endDate;

  @JsonProperty("location")
  @NotBlank(message = "Location is required")
  private String location;

  @JsonProperty("description")
  private String description;

  @JsonProperty("participants")
  private List<Long> participants;

  @JsonProperty("maxParticipant")
  @NotNull(message = "Max number of Participant is required")
  private int maxParticipant;
}
