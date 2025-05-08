# Systemarchitektur

**DeepExtension** wurde als modulare, skalierbare und unternehmensgerechte Plattform konzipiert, um den gesamten Lebenszyklus der KI-Modellentwicklung zu verwalten – von der Datenvorbereitung bis hin zur Bereitstellung. Dieses Dokument bietet einen Überblick über die Architektur auf hoher Ebene.

---

## 🏗️ Überblick

Auf einen Blick besteht DeepExtension aus den folgenden Hauptkomponenten:

---

## 🖥️ 1. Benutzeroberflächen

- **Webbasierte Benutzeroberfläche** (Self-Hosted): Die primäre Schnittstelle für die meisten Benutzer  
- **RESTful API**: Für programmatischen Zugriff, CI/CD-Integration oder Automatisierung

---

## ⚙️ 2. Anwendungsschicht

Diese Schicht steuert die Benutzererfahrung und verarbeitet:

- **Benutzer- und Projektverwaltung**
- **Aufgabenplanung** (Training, Auswertung, Feintuning)
- **Modelllebenszyklus**: Verfolgung von Versionen, Leistung und Nutzung
- **Datenversionierung**: Unterstützt inkrementelle, gelabelte Datensätze
- **Auswertungswerkzeuge**: Enthält Benchmarks, JSON-Validatoren, Geschäftsregel-Tests
- **Sicherheit**: RBAC, Token-Authentifizierung, Audit-Logs

---

## 🧠 3. KI-Kernschicht

Hier wird DeepExtension KI-spezifisch:

- **GRPO-Engine**: Benutzerdefinierte Logik für Reinforcement Learning mit Prompt-Optimierung  
- **Trainings-Job-Orchestrator**: Verwalten und steuern von LLM-Feintuning-Aufgaben  
- **Anpassbare Trainingslogik**: Eigener Trainingscode kann fast beliebig eingebunden werden – mit nur minimalen Anpassungen wird er von DeepExtension nahtlos ausgeführt, überwacht und nachverfolgt

---

## 🧰 4. Infrastrukturschicht

Ausführung der Berechnungs- und Speicherkomponenten:

- **CUDA-GPU-Unterstützung** auf Ubuntu für Training und Inferenz  
- **Lokale macOS-Unterstützung** für Entwicklung und Vorschau  
- **Docker Compose**: Verwaltung aller Dienste (Datenbank, Vektorspeicher, API, UI)  
- **Speicher-Backends**:

  - **Dateispeicher**: Verwaltung von Rohdatensätzen, Modell-Checkpoints und Artefakten  
  - **Vektordatenbanken**: Speicherung und Abfrage von Embeddings (z. B. für semantische Suche oder RAG)  
  - **Relationale Datenbanken (z. B. PostgreSQL)**: Speicherung von Metadaten, Konfigurationen und Trainingsaufzeichnungen

---

## 🔗 Integrationen

DeepExtension unterstützt Integrationen mit:

- **LLM-Anbietern**: OpenAI, Qwen, Claude, SiliconFlow usw.  
- **Lokale Modelltools**: Reibungslose Zusammenarbeit mit Tools wie **LM Studio**, **Ollama** und anderen für lokale Modell-Experimente und -Bereitstellungen  
<!-- - **Vektordatenbanken** -->

---

## 🔐 Sicherheitsfunktionen

- Rollenbasierte Zugriffskontrolle (RBAC)  
- Projektbasierte Berechtigungsebenen  
- Protokollierung aller Aktionen und Rückverfolgbarkeit  
- Option für isolierte (air-gapped) Bereitstellungen

---

## 📦 Bereitstellungsoptionen

| Zielumgebung         | Beschreibung                                 |
|----------------------|----------------------------------------------|
| `Ubuntu + CUDA`      | Optimiert für leistungsintensives Training   |
| `macOS` (Entwicklung) | Läuft über Docker (ideal für lokale Nutzung oder Schulung) |
| `Self-hosted SaaS`   | Vollständige Bereitstellung für interne oder externe Nutzung |

---

## 🚀 Zusammenfassung

**DeepExtension** ist so konzipiert, dass es sich sowohl für experimentelle Forschung als auch für unternehmenskritische Anwendungen eignet. Die schichtenbasierte Architektur erleichtert die Integration in bestehende KI-Stacks und ermöglicht gleichzeitig die vollständige Kontrolle über Modell-Workflows.
