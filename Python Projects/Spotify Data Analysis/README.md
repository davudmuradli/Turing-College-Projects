# 📊 Spotify Top 50 Tracks Analysis

A Data Exploration Project Using Python, Pandas, NumPy, and Jupyter Notebook.

---

## 📁 Project Overview

This project analyzes a dataset of **Spotify Top 50 Tracks** using **Python** and **Jupyter Notebook**.

The goal was to explore the dataset, clean the data, identify trends, and answer several analytical questions such as:

* Who are the **most popular artists**?
* Which **genre** dominates the Top 50?
* What are the **longest and shortest tracks**?
* How do **music features** compare across genres?
* Which features are **strongly correlated**?

All analysis was conducted interactively within a Jupyter Notebook, making it easy to visualize and test different operations step-by-step.

---

## 🧰 Technologies Used

* **Python 3**
* **Jupyter Notebook**
* **Pandas** (data manipulation)
* **NumPy** (numerical operations)

---

## 📄 Dataset Summary

* **Observations (rows):** 50
* **Features (columns):** 16
    * **5 categorical features:** `artist`, `album`, `track_name`, `track_id`, `genre`
    * **11 numerical features:** `energy`, `danceability`, `key`, `loudness`, `acousticness`, `speechiness`, `instrumentalness`, `liveness`, `valence`, `tempo`, `duration_ms`

---

## 🏆 Key Findings

### 🎤 Top Artists

Based on how many songs each artist has in the Top 50, the most popular artists are:

1.  **Billie Eilish**
2.  **Dua Lipa**
3.  **Travis Scott**

These artists appear multiple times in the dataset, indicating their strong popularity.

### 💿 Most Popular Album

The album with the most tracks present in the Top 50 is:

> ⭐ **Future Nostalgia (Dua Lipa)**

This album appears frequently in the dataset and strongly influenced the genre and feature averages.

### ⏱️ Track Duration Insights

* **Longest Track:** *Sicko Mode* – significantly longer than most other songs.
* **Shortest Track:** *Mood (feat. iann dior)* – one of the shortest songs in the dataset.

### 🎶 Most Popular Genre

The genre with the highest number of tracks in the Top 50 is:

> ⭐ **Pop**

Pop dominates the dataset and shows strong representation across several artists and albums.

### 🔗 Feature Correlations

Using the correlation matrix, the strongest positive correlation was found between:

> ⭐ **Energy ↔ Loudness**

This makes sense musically:

* **Loud** songs tend to feel **more energetic**
* **Quiet** songs often have **lower energy scores**

This correlation helps confirm the dataset’s reliability and the real-world connection between musical properties.

---

## 🎚️ Genre-Based Feature Comparisons

To better understand stylistic differences, three key audio features were compared across four major genres: **Pop**, **Hip-Hop/Rap**, **Dance/Electronic**, and **Alternative/Indie**.

The features evaluated were:

### 1️⃣ Danceability

Measures how suitable a track is for dancing (higher = more danceable).

| Genre | Interpretation |
| :--- | :--- |
| **Hip-Hop/Rap & Dance/Electronic** | Highest danceability — rhythmic and beat-heavy |
| **Pop** | Moderately danceable |
| **Alternative/Indie** | Lowest danceability — more experimental, less rhythm-driven |

### 2️⃣ Loudness

Average volume level in decibels (lower number = quieter).

| Genre | Interpretation |
| :--- | :--- |
| **Dance/Electronic** | Loudest — high-energy club production |
| **Pop** | Moderately loud |
| **Alternative/Indie** | Softer — often acoustic or minimalistic |
| **Hip-Hop/Rap** | Wide range but generally loud |

### 3️⃣ Acousticness

Probability that a track is acoustic (higher = more acoustic).

| Genre | Interpretation |
| :--- | :--- |
| **Alternative/Indie** | Most acoustic — guitars, organic instruments |
| **Pop** | Mix of digital + acoustic elements |
| **Hip-Hop/Rap** | Low acousticness |
| **Dance/Electronic** | Lowest — mostly synthesized and digital sounds |

### 📈 What These Results Mean

This analysis shows how genres differ not only in style but also in their measurable audio properties.

* **Pop:** balanced, polished, and accessible
* **Hip-Hop/Rap:** rhythmic, energetic, and fast-paced
* **Dance/Electronic:** loud, upbeat, club-oriented
* **Alternative/Indie:** softer, more acoustic, less focused on danceability

These insights help highlight why certain genres dominate charts and streaming platforms—they align with listener preferences for energy, rhythm, or emotional tone.

---

## 📚 Conclusion

Using Python and Jupyter Notebook, this project explored the Spotify Top 50 dataset and identified patterns in artist popularity, genre dominance, track features, and audio correlations. The combination of data cleaning, exploratory analysis, and feature comparison provides a clear picture of what defines today’s most popular music.
