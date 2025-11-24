//package com.pl.eplzone.repository;
//
//import com.pl.eplzone.model.Player;
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;
//
//import java.util.Optional;
//
//@Repository
//public interface PlayerRepository extends JpaRepository<Player, String> {
//
//    void deleteByPlayer(String playerName);
//
//    Optional<Player> findByPlayer(String name);
//}



package com.pl.eplzone.repository;

import com.pl.eplzone.model.Player;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface PlayerRepository extends JpaRepository<Player, UUID> {

    // Check if a player exists by name
    boolean existsByPlayer(String playerName);

    // Check if a player exists by name excluding a specific ID
    boolean existsByPlayerAndIdNot(String playerName, UUID id);

    // Find player by name
    Optional<Player> findByPlayer(String playerName);

    // Find all players from a specific team
    List<Player> findByTeam(String team);

    // Find all players by position
    List<Player> findByPosContainingIgnoreCase(String position);

    // Find all players by nation
    List<Player> findByNationContainingIgnoreCase(String nation);

    // Find players by team and position
    List<Player> findByTeamAndPos(String team, String position);

    // Custom query to search players by multiple criteria
    @Query("SELECT p FROM Player p WHERE " +
            "(:team IS NULL OR p.team = :team) AND " +
            "(:position IS NULL OR p.pos = :position) AND " +
            "(:nation IS NULL OR LOWER(p.nation) LIKE LOWER(CONCAT('%', :nation, '%')))")
    List<Player> searchPlayers(@Param("team") String team,
                               @Param("position") String position,
                               @Param("nation") String nation);

    // Find top goal scorers
    @Query("SELECT p FROM Player p ORDER BY p.gls DESC")
    List<Player> findTopScorers();

    // Find players by team ordered by goals
    @Query("SELECT p FROM Player p WHERE p.team = :team ORDER BY p.gls DESC")
    List<Player> findTeamTopScorers(@Param("team") String team);
}