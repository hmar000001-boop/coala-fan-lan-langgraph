# Chapter 1 Outline — Review and Revision 2.0

**Book:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Part:** I — CoALA: Understanding Language Agents as Cognitive Systems  
**Chapter:** 1 — Why Do Language Agents Need Cognitive Architectures?  
**Status:** Revised outline submitted for approval; chapter not yet written  
**Target chapter length:** 12–16 pages  
**Audience:** Beginners with basic programming knowledge  
**Language:** English

---

## 1. Editorial decision

The first outline had a sound practical entry point, but it was too narrowly framed around the difficulty of coordinating information, decisions, and external actions. That framing is useful, but it does not fully reproduce the intellectual progression of the original CoALA paper.

The original paper first connects language agents to the history of production systems and cognitive architectures. It then draws an analogy between production systems and language models, describes the progression from ordinary LLM calls to language agents and cognitive language agents, and introduces CoALA as a conceptual framework for organizing and designing such systems.

This revision restores that progression. The production-incident example remains, but it is explicitly an illustration created for this book—not an example or empirical case study from the CoALA paper.

The chapter will therefore move through this sequence:

1. Start with the difference between a model call and a system that interacts with an environment.
2. Show how language-agent designs add interaction, feedback, and increasingly sophisticated internal processes.
3. Explain why these systems need a vocabulary and a way to describe their organization.
4. Introduce the historical bridge through production systems and cognitive architectures.
5. Return to a concrete incident scenario to make the architectural questions tangible.
6. Introduce CoALA's purpose and three dimensions as a preview, leaving their detailed treatment to later chapters.

This sequence is more faithful to the original paper and gives a beginner a reason to care about the framework before encountering its formal structure.

## 2. Chapter purpose

By the end of the chapter, the reader should understand why an LLM-based agent is better understood as a system organized around a model than as a model call alone.

The reader should also understand the specific problem CoALA addresses: language-agent work was developing sophisticated combinations of memory, actions, reasoning, planning, and environmental interaction, but individual projects used different terminology and abstractions. CoALA provides a conceptual framework to characterize, compare, and help design these systems.

The chapter is an introduction to the motivation and scope of CoALA. It is not intended to teach the complete architecture, all memory types, all action types, or the detailed decision procedure. Those topics belong to Chapters 2–8.

## 3. Detailed section outline

### 1.1 — A model call is not yet the whole system

**Opening scene**

Begin with a simple interaction: a user asks a language model why a software service is failing. The model returns a plausible explanation.

Then change the task. The user now expects the system to inspect observations, consult relevant information, consider possible next steps, interact with a service or tool, and take account of what happens afterward.

**Develop naturally**

- What a language model call receives and produces.
- Why a generated answer can be useful without being an agent that interacts with an environment.
- The difference between producing a response and participating in an ongoing interaction.
- The idea of an environment: the external setting with which the system exchanges information or actions.
- The idea of an observation: information received from that environment.
- The idea of an action: something the system does that is represented as part of its operation.

**Teaching purpose**

The reader should discover the distinction through the example. Avoid opening with abstract definitions of “agent,” “environment,” or “action.”

**Source grounding**

Use CoALA's introduction and its distinction between ordinary LLM use, language agents, and cognitive language agents. Do not imply that every model call is an agent or that the paper defines an agent solely by tool use.

### 1.2 — How language-model systems move beyond a single response

Use the progression depicted in the original paper to explain three increasingly capable patterns.

**A. A model used for text input and text output**

- The prompt is supplied to the model.
- The model generates a response.
- The interaction may end with that response.

**B. A language agent interacting with an environment**

- An observation from the environment is represented in a form the model can process.
- The model helps choose or generate an action.
- The action is carried out.
- The environment can provide another observation.

Introduce “feedback loop” only after the reader has seen this repeated interaction: an action changes what the system can observe next, and the new observation can influence the next decision.

**C. A cognitive language agent**

- The system does not only interact with the external environment.
- It may also use the model for intermediate reasoning.
- It may retrieve information from memory.
- It may learn from experience by updating longer-term information.
- These internal processes can influence later decisions and behavior.

**Teaching purpose**

Show that these are not merely three names for the same thing. Each step adds organizational capabilities that matter when describing the complete system.

**Source grounding**

Follow the conceptual distinction in CoALA's Figure 1 and Sections 1 and 3. Do not imply that every language agent has all the capabilities shown in the third pattern.

### 1.3 — Why increasingly capable agents are difficult to describe consistently

Now explain the problem that motivates a common conceptual framework.

- Different projects describe parts of their systems using terms such as tool use, grounding, actions, reasoning, planning, and memory.
- The same broad term can refer to different underlying operations.
- Two systems may appear similar at the feature level while organizing their information and control differently.
- Without shared conceptual distinctions, it becomes harder to compare systems, understand how they are evolving, and design new systems with reusable abstractions.

Use one small comparison: two agents may both be described as having “memory,” while one retrieves information from a store and another maintains a persistent library of reusable procedures. The point is not to teach memory architecture here; it is to show why a feature label alone is insufficient.

**Teaching purpose**

Make the need for a framework arise from an observable problem in how systems are described, rather than simply asserting that architectures are useful.

**Boundary**

Do not introduce Fan & Lan's seven-field mechanism representation or its evidence and migration scales here. Those belong to Part II. Chapter 1 should establish the CoALA motivation on its own terms.

### 1.4 — The historical bridge: production systems and cognitive architectures

This section restores an important part of the original paper's reasoning.

**A. First, understand a production system**

Use a simple rule:

- A condition is checked.
- When the condition is satisfied, an associated action may be applied.
- Repeated rule application can produce a sequence of changes.

Explain the term “production rule” only after showing this condition-and-action example. Keep the treatment intuitive; formal string-rewriting notation is unnecessary in this chapter.

**B. Why production systems matter to the story**

- CoALA's paper traces production systems from early string-manipulation ideas toward systems capable of more complex, structured behavior.
- As these systems became more capable, the question was no longer only which rule could apply; the system also needed an organized way to control the selection and application of rules.

**C. Introduce a cognitive architecture**

Explain that a cognitive architecture provides an organized account of how a system's components and processes work together, including how control is exercised over time.

Do not turn this into a survey of historical architectures. The detailed historical discussion is not the purpose of Chapter 1.

**D. The analogy with language models**

- The paper draws an analogy between production systems and LLMs: production rules specify possible changes to strings, while an LLM defines a distribution over possible changes or additions to text.
- This is an analogy used to motivate architectural ideas, not a claim that an LLM is literally a traditional production system.
- The paper argues that ideas from cognitive architectures can help organize LLM-based systems into language agents.

**Teaching purpose**

Help readers understand why CoALA draws on cognitive science and symbolic AI instead of presenting its framework as an arbitrary collection of software components.

### 1.5 — A running example: investigating a production incident

Return to the opening scenario and develop it just enough to reveal the architectural questions.

**Illustrative scenario created for this book**

Product X's payment service is returning HTTP 500 errors. The agent is asked to investigate and help determine an appropriate response.

Walk through the situation without implementing it:

1. The system receives the report and relevant observations.
2. It may need information that is not present in the initial request.
3. It may need to retrieve information from records or previously retained knowledge.
4. It may reason about possible explanations.
5. It may consider different actions, such as gathering another observation or proposing a diagnostic operation.
6. An action may produce a new observation.
7. That observation may change what the system should consider next.

Use the scenario to pose three questions:

- **Information:** What information does the agent have, and where is it kept?
- **Actions:** What can the agent do internally, and what can it do in the environment?
- **Decision process:** How does the agent determine what to do next, and how does it continue after new information arrives?

**Important boundaries**

- State explicitly that Product X and this incident are a book-created teaching example, not a case from either paper.
- Do not make the scenario imply that CoALA prescribes incident-management workflows, production authorization policies, specific tools, or a particular recovery procedure.
- Do not discuss implementation details such as Java classes, database schemas, graph nodes, or framework APIs.

**Teaching purpose**

The example should connect the historical and conceptual discussion to a practical problem and prepare the reader to recognize the three dimensions of CoALA.

### 1.6 — CoALA: a framework for organizing language agents

Introduce CoALA directly and accurately.

- Expand the name: Cognitive Architectures for Language Agents.
- Describe it as a conceptual framework for characterizing and designing general-purpose language agents.
- Explain that CoALA positions the LLM as the core component of a larger cognitive architecture—not as the entire agent by itself.
- Explain that the paper uses the framework both to organize existing work and to identify directions for future development.

Then preview the three dimensions without attempting to teach them completely:

**Information storage**

The agent's information is organized through working memory and long-term memory. The detailed memory types and their roles are the subject of Chapters 2 and 3.

**Action space**

The framework distinguishes internal actions, which interact with the agent's memories, from external actions, which interact with an external environment. The detailed action categories are developed in Chapters 4 and 5.

**Decision-making procedure**

The agent follows a repeated decision cycle. Retrieval and reasoning can contribute to planning; planning considers candidate learning or grounding actions; an action is selected and executed; an observation may follow; and the cycle can begin again. The detailed treatment is reserved for Chapters 6–8.

**Teaching purpose**

Give readers a compact mental map of the framework while preserving the conceptual work for the chapters designed to explain each part.

### 1.7 — What CoALA is—and what it is not

Prevent misunderstandings before they become embedded in the reader's mental model.

**What the paper contributes**

- A conceptual way to organize language agents around memory, action, and decision-making.
- A framework that can be used to characterize varied systems.
- A way to connect language-agent design to earlier work on production systems and cognitive architectures.
- A structure for retrospective comparison and prospective design discussion.

**What should not be inferred**

- CoALA is not a ready-to-use Java library, runtime, or deployment architecture.
- It does not prescribe LangGraph4j, LangChain4j, Maven, a database, or a cloud/on-device deployment model.
- It does not require every agent to use every memory category or every action category in the same way.
- It should not be reduced to a single fixed reasoning strategy.
- A conceptual mapping of an implementation to CoALA does not, by itself, prove that the implementation realizes every detail discussed in the paper.

**Teaching purpose**

Clearly separate the paper's conceptual contribution from the engineering choices made later in the book.

### 1.8 — How to read the rest of Part I

Give the reader a short, accurate roadmap.

- **Chapter 2:** establish the architecture's three dimensions and how they fit together.
- **Chapter 3:** examine working memory and long-term memory, including episodic, semantic, and procedural memory.
- **Chapter 4:** explain retrieval, reasoning, and learning as internal actions.
- **Chapter 5:** explain external actions and grounding.
- **Chapter 6:** develop planning and candidate proposal.
- **Chapter 7:** examine evaluation and selection.
- **Chapter 8:** reconstruct the complete iterative decision process, including how internal and external actions can be interleaved.

End by returning to the incident scenario. The reader should now be able to see that the questions raised by the incident are not separate implementation details: they correspond to the organizing questions CoALA makes explicit.

## 4. Learning outcomes

After reading Chapter 1, a beginner should be able to:

1. Explain why a language-model call, a language agent, and a cognitive language agent are not interchangeable descriptions.
2. Describe, at a high level, how interaction with an environment creates a feedback loop.
3. Explain why memory, actions, and decision processes need a consistent conceptual vocabulary.
4. Describe the intuitive relationship between production systems and cognitive architectures.
5. Explain why CoALA draws on that history when organizing language agents.
6. Name CoALA's three dimensions without yet needing to explain all their internal details.
7. Distinguish a claim made by the CoALA paper from an illustrative example created for this book or an engineering decision made by an implementer.

## 5. Planned teaching devices

The chapter should use a small number of purposeful visuals, not decorative diagrams.

1. **Figure 1 — Three ways of using a language model:** text input/output; interaction with an external environment; cognitive language agent with internal processes as well as environmental interaction. This should be an original, clearly attributed conceptual redraw of the progression in CoALA Figure 1, not a copied figure.
2. **Figure 2 — A production rule in plain language:** a condition followed by an action, with one simple example. This is a teaching illustration of the production-system concept.
3. **Figure 3 — Three questions raised by the Product X incident:** information, actions, and decision-making. This is a bridge to CoALA's three dimensions, not a substitute for the formal architecture diagram in Chapter 2.
4. **Running-example callouts:** short returns to Product X at the moments where they clarify a concept. Do not allow the scenario to dominate the chapter.

## 6. Terminology introduction order

Terms must be introduced in context, at the point where the reader needs them. They must not appear first in a glossary-style block.

| First appearance | Term | How it should be introduced |
|---|---|---|
| §1.1 | Model call | Show the input sent to a model and the response it returns. |
| §1.1 | Environment | Introduce as the external setting with which a system interacts. |
| §1.1 | Observation | Show as information received from that setting. |
| §1.1 | Action | Show as something the system does in response to its current situation. |
| §1.2 | Feedback loop | Explain through repeated action and new observation. |
| §1.2 | Language agent | Introduce through the LLM's interaction with an environment. |
| §1.2 | Cognitive language agent | Introduce when internal reasoning, memory, and learning processes are added. |
| §1.4 | Production system / production rule | Start with a simple condition-and-action example. |
| §1.4 | Cognitive architecture | Explain as an organized account of components and control, motivated by the production-system history. |
| §1.6 | CoALA | Name the framework after the motivation has been established. |
| §1.6 | Working memory / long-term memory | Preview only; full explanation belongs to Chapters 2–3. |
| §1.6 | Internal action / external action | Preview only; full explanation belongs to Chapters 4–5. |
| §1.6 | Grounding | Introduce only as the framework's term for external interaction; explain fully in Chapter 5. |
| §1.6 | Decision cycle | Preview as repeated decision-making; detail belongs to Chapters 6–8. |

## 7. Scope exclusions for this chapter

To preserve a clear progression and avoid repetition:

- No detailed taxonomy of episodic, semantic, or procedural memory; that belongs to Chapter 3.
- No complete explanation of retrieval, reasoning, learning, or grounding actions; those belong to Chapters 4 and 5.
- No detailed proposal/evaluation/selection algorithm; those belong to Chapters 6 and 7.
- No complete walkthrough of iteration and interleaving; that belongs to Chapter 8.
- No Fan & Lan mechanism bundles, seven-field mechanism representation, E1–E4 evidence relation, or D0–D4 migration depth; those belong to Part II.
- No ToT, RAP, or other research frameworks as additional theoretical foundations.
- No Java implementation or framework-specific code.
- No engineering policy presented as if it were required by CoALA.

## 8. Source and attribution plan

**Primary theoretical source for this chapter**

- **[CoALA]** Sumers, T. R., Yao, S., Narasimhan, K., and Griffiths, T. L., *Cognitive Architectures for Language Agents*, arXiv:2309.02427; published in *Transactions on Machine Learning Research* (2024). The relevant foundation is the paper's Introduction and Sections 2–4, especially the historical bridge and the introduction of the CoALA framework.

**Attribution discipline**

- Mark claims that are directly supported by the original paper with the book's `[CoALA]` source label.
- Use plain prose such as “In the running example…” to identify book-created illustrations; do not create additional formal source labels.
- Clearly identify explanations that restate a paper concept in beginner-friendly language as explanations, not new mechanisms.
- Do not use Fan & Lan to reinterpret or silently modify the CoALA baseline in Part I. Fan & Lan will be studied in its own right in Part II.
- Do not attribute the Product X incident, its details, or any implementation decisions to either paper.

**Primary source link**

- CoALA paper: https://arxiv.org/abs/2309.02427

## 9. Acceptance criteria for the eventual chapter

The chapter is ready for approval only when all of the following are true:

- It follows the progression from model call to language agent to cognitive language agent.
- It includes the production-system and cognitive-architecture bridge that motivates CoALA in the original paper.
- It explains why the field needs a consistent conceptual framework before presenting CoALA.
- It introduces the three dimensions as a preview without prematurely duplicating Chapters 2–8.
- It uses Product X only as an explicitly book-created illustration.
- It distinguishes conceptual framework claims from implementation prescriptions.
- It explains each new term naturally before relying on it.
- It remains understandable to a beginner with basic programming knowledge.
- Every theoretical claim is traceable to the original CoALA paper.
- It does not introduce Fan & Lan mechanisms or unrelated theoretical frameworks.

---

## Approval request

**Please approve or request changes to this revised Chapter 1 outline.**

No chapter prose will be written until this outline is explicitly approved.

