package com.pl.eplzone.repository;

import com.pl.eplzone.model.Player;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PlayerRepository extends JpaRepository<Player, String> {

    void deleteByPlayer(String playerName);

    Optional<Player> findByPlayer(String name);
}
