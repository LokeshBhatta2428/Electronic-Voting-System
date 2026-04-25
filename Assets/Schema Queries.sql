Create Database Election;
use election;

CREATE TABLE constituency (
    constituency_id   INT          PRIMARY KEY,
    constituency_name VARCHAR(150),
    province          VARCHAR(100)
);

CREATE TABLE polling_station (
    station_id        INT          PRIMARY KEY,
    location          VARCHAR(255),
    constituency_id   INT,
    FOREIGN KEY (constituency_id) REFERENCES constituency(constituency_id)
);

CREATE TABLE voter (
    voter_id          INT          PRIMARY KEY,
    name              VARCHAR(150),
    citizenship_no    VARCHAR(30),
    address           VARCHAR(255),
    dob               DATE,
    constituency_id   INT,
    FOREIGN KEY (constituency_id) REFERENCES constituency(constituency_id)
);

CREATE TABLE registered_voter (
    voter_id          INT          PRIMARY KEY,
    registration_date DATE,
    reg_status        VARCHAR(20),
    FOREIGN KEY (voter_id) REFERENCES voter(voter_id)
);

CREATE TABLE unregistered_voter (
    voter_id          INT          PRIMARY KEY,
    FOREIGN KEY (voter_id) REFERENCES voter(voter_id)
);
 
CREATE TABLE voter_registration (
    registration_id   INT          PRIMARY KEY,
    voter_id          INT,
    station_id        INT,
    constituency_id   INT,
    registration_date DATE,
    status            VARCHAR(20),
    FOREIGN KEY (voter_id)        REFERENCES voter(voter_id),
    FOREIGN KEY (station_id)      REFERENCES polling_station(station_id),
    FOREIGN KEY (constituency_id) REFERENCES constituency(constituency_id)
);

CREATE TABLE political_party (
    party_id          INT          PRIMARY KEY,
    party_name        VARCHAR(150),
    symbol            VARCHAR(100)
);
 
CREATE TABLE election (
    election_id       INT          PRIMARY KEY,
    election_type     VARCHAR(50),
    election_date     DATE
);
 
CREATE TABLE candidate (
    candidate_id      INT          PRIMARY KEY,
    candidate_name    VARCHAR(150),
    party_id          INT,
    election_id       INT,
    FOREIGN KEY (party_id)    REFERENCES political_party(party_id),
    FOREIGN KEY (election_id) REFERENCES election(election_id)
);
 
CREATE TABLE vote (
    vote_id           INT          PRIMARY KEY,
    registration_id   INT,
    candidate_id      INT,
    election_id       INT,
    vote_timestamp    TIMESTAMP,
    FOREIGN KEY (registration_id) REFERENCES voter_registration(registration_id),
    FOREIGN KEY (candidate_id)    REFERENCES candidate(candidate_id),
    FOREIGN KEY (election_id)     REFERENCES election(election_id)
);
 
CREATE TABLE election_result (
    result_id         INT          PRIMARY KEY,
    election_id       INT,
    candidate_id      INT,
    total_votes       INT,
    last_updated      TIMESTAMP,
    FOREIGN KEY (election_id)  REFERENCES election(election_id),
    FOREIGN KEY (candidate_id) REFERENCES candidate(candidate_id)
);