# Database Schema Documentation

## Ticket System Schema

```mermaid
erDiagram
    tickets {
        uuid id PK
        text title
        text description
        text status
        text priority
        text[] tags
        jsonb custom_fields
        jsonb conversation_history
        jsonb internal_notes
        jsonb feedback
        text source_channel
        timestamptz created_at
        timestamptz updated_at
        uuid created_by FK
        text customer_email FK
        uuid[] assigned_to FK
    }

    customers {
        uuid id PK
        text first_name
        text last_name
        text[] communication_channels
        text preferred_language
        text email UK
        jsonb feedback_history
    }

    auth.users {
        uuid id PK
    }

    tickets ||--o{ auth.users : "created_by"
    tickets }o--o{ auth.users : "assigned_to"
    tickets ||--|| customers : "customer_email"
    customers ||--|| auth.users : "extends"
```

## Tables

### tickets

Core table for storing support tickets. Designed for flexibility while maintaining structure for essential fields.

#### Fields
- `id`: UUID, primary key, auto-generated
- `title`: Text, required, ticket summary
- `description`: Text, required, detailed explanation of the ticket/issue
- `status`: Text, required, enum:
  - `new`: Ticket created but not yet assigned to support staff
  - `open`: Assigned to support staff and being worked on
  - `pending`: Waiting for customer reply
  - `closed`: Issue has been resolved and ticket is closed
- `priority`: Text, required, enum:
  - low
  - medium
  - high
- `tags`: Text array, optional, for categorization and filtering
- `custom_fields`: JSONB, optional, for flexible metadata storage
- `conversation_history`: JSONB, stores all messages and internal notes in the format:
  ```json
  {
    "messages": [
      {
        "id": "uuid",
        "content": "message text",
        "created_at": "timestampz",
        "created_by": "user_id",
        "attachments": []
      }
    ]
  }
  ```
- `internal_notes`: JSONB, stores internal staff-only notes in the format:
  ```json
  {
    "notes": [
      {
        "id": "uuid",
        "content": "text content",
        "created_at": "timestamptz",
        "created_by": "user_id"
      }
    ]
  }
  ```
- `feedback`: JSONB, stores customer feedback in the format:
  ```json
  {
    "rating": 1-5,
    "comment": "text feedback",
    "submitted_at": "timestamptz"
  }
  ```
- `source_channel`: Text, tracks where the ticket originated from (e.g., email, web, chat, widget)
- `created_at`: Timestampz (with timezone), auto-set on creation
- `updated_at`: Timestampz (with timezone), auto-updated
- `created_by`: UUID, references auth.users, ticket creator
- `customer_email`: Text, references customers(email), provides an additional way to link tickets to customers
- `assigned_to`: UUID array, references auth.users, assigned support staff members

#### Relationships
- Links to Supabase auth.users table for both creator and assignee
- Links to customers table via customer_email for customer information

#### Notes
- Uses JSONB for custom fields to maintain flexibility
- Simple array for tags as per MVP requirements
- Predefined status and priority values for simplicity
- Automatic timestamp management for created_at and updated_at
- Conversation history stored as JSONB for flexibility and simpler querying

### customers

Core table for storing customer information. Extends the auth.users table with additional customer-specific fields.

#### Fields
- `id`: UUID, primary key, references auth.users(id)
- `first_name`: Text, required, customer's first name
- `last_name`: Text, required, customer's last name
- `communication_channels`: Text array, stores the channels customer has used (e.g., 'email', 'chat', 'widget')
- `preferred_language`: Text, customer's preferred language for communication
- `email`: Text, required, unique, customer's email address
- `feedback_history`: JSONB, stores customer's feedback history in the format:
  ```json
  {
    "feedback": [
      {
        "rating": 1-5,
        "comment": "text feedback",
        "submitted_at": "timestamptz",
        "ticket_id": "uuid"
      }
    ]
  }
  ```

#### Relationships
- Extends Supabase auth.users table (one-to-one relationship)
- Linked to tickets table via email for ticket history

#### Notes
- Uses array for communication channels to track all channels used by customer
- Feedback history stored as JSONB for flexibility and simpler querying
- Links to auth.users for authentication and base user information
