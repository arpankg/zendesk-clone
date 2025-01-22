-- Sample ticket data for the support system
-- Includes various statuses, priorities, and ticket types

-- Ticket 1: New ticket from Test User
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    'c0d3b4e5-f6a7-4b8c-9d0e-1a2b3c4d5e6f',
    'Cannot access dashboard',
    'I am unable to access my dashboard after logging in. The page shows a blank screen.',
    'new',
    'high',
    ARRAY['login', 'dashboard', 'access'],
    '{}',
    '{
        "events": [
            {
                "id": "550e8400-e29b-41d4-a716-446655440000",
                "type": "message",
                "content": "I am unable to access my dashboard after logging in",
                "created_at": "2024-12-20T14:25:00Z",
                "created_by_uuid": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
                "created_by_first_name": "Test",
                "created_by_last_name": "User",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440001",
                "type": "message",
                "content": "Hi! I''m sorry you''re having trouble accessing your dashboard. Could you please try clearing your browser cache and cookies, then logging in again?",
                "created_at": "2024-12-20T14:30:00Z",
                "created_by_uuid": "98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8",
                "created_by_first_name": "Sarah",
                "created_by_last_name": "Johnson",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440002",
                "type": "message",
                "content": "I''ll try that now and let you know if it works.",
                "created_at": "2024-12-20T14:32:00Z",
                "created_by_uuid": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
                "created_by_first_name": "Test",
                "created_by_last_name": "User",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440003",
                "type": "status-update",
                "old_value": "new",
                "new_value": "open",
                "created_at": "2024-12-20T14:33:00Z",
                "created_by_uuid": "98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8",
                "created_by_first_name": "Sarah",
                "created_by_last_name": "Johnson",
                "visibility": "public"
            }
        ]
    }'::jsonb,
    '{"notes": []}'::jsonb,
    '{"rating": 0, "comment": "", "submitted_at": null}'::jsonb,
    'web',
    now(),
    now(),
    '5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58',
    'test@gmail.com',
    '[]'::jsonb
);

-- Ticket 2: Closed ticket with feedback from Sarah Miller
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    '7e8f9a0b-c1d2-4e3f-a4b5-6c7d8e9f0a1b',
    'Billing inquiry about premium plan',
    'I have some questions about the premium plan pricing and features.',
    'closed',
    'medium',
    ARRAY['billing', 'premium', 'pricing'],
    '{"plan_type": "premium", "billing_cycle": "annual"}',
    '{
        "events": [
            {
                "id": "550e8400-e29b-41d4-a716-446655440004",
                "type": "message",
                "content": "I have questions about premium plan pricing",
                "created_at": "2024-12-15T09:00:00Z",
                "created_by_uuid": "f23c5c88-2322-4c2d-9f59-43e79a9b5c44",
                "created_by_first_name": "Sarah",
                "created_by_last_name": "Miller",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440005",
                "type": "message",
                "content": "Hi Sarah! I''d be happy to help explain our premium plan pricing. What specific information would you like to know?",
                "created_at": "2024-12-15T09:10:00Z",
                "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_by_first_name": "Lisa",
                "created_by_last_name": "Brown",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440006",
                "type": "assignment-added",
                "agent_id": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_at": "2024-12-15T09:10:00Z",
                "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_by_first_name": "Lisa",
                "created_by_last_name": "Brown",
                "visibility": "public"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440007",
                "type": "field-added",
                "field_name": "plan_type",
                "new_value": "premium",
                "created_at": "2024-12-15T09:11:00Z",
                "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_by_first_name": "Lisa",
                "created_by_last_name": "Brown",
                "visibility": "private"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440008",
                "type": "message",
                "content": "I''m interested in annual billing. What kind of discount do you offer compared to monthly?",
                "created_at": "2024-12-15T09:12:00Z",
                "created_by_uuid": "f23c5c88-2322-4c2d-9f59-43e79a9b5c44",
                "created_by_first_name": "Sarah",
                "created_by_last_name": "Miller",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440009",
                "type": "message",
                "content": "With annual billing, you get a 20% discount compared to monthly billing. For the premium plan, that would be $1,200/year instead of $1,500 ($125/month).",
                "created_at": "2024-12-15T09:14:00Z",
                "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_by_first_name": "Lisa",
                "created_by_last_name": "Brown",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440010",
                "type": "field-added",
                "field_name": "billing_cycle",
                "new_value": "annual",
                "created_at": "2024-12-15T09:16:00Z",
                "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_by_first_name": "Lisa",
                "created_by_last_name": "Brown",
                "visibility": "private"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440011",
                "type": "status-update",
                "old_value": "open",
                "new_value": "closed",
                "created_at": "2024-12-15T09:18:00Z",
                "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_by_first_name": "Lisa",
                "created_by_last_name": "Brown",
                "visibility": "public"
            }
        ]
    }'::jsonb,
    '{
        "notes": [
            {
                "id": "note1",
                "content": "Customer interested in annual plan",
                "created_at": "2024-12-15T09:12:00Z",
                "created_by": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f"
            }
        ]
    }'::jsonb,
    '{
        "rating": 4,
        "comment": "Quick response, but needed follow-up",
        "submitted_at": "2024-12-15T09:15:00Z"
    }'::jsonb,
    'chat',
    now() - interval '5 days',
    now() - interval '5 days',
    'f23c5c88-2322-4c2d-9f59-43e79a9b5c44',
    'sarah.miller@example.com',
    '[]'::jsonb
);

-- Ticket 3: Pending ticket from Carlos Garcia
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    '2b3c4d5e-f6a7-8b9c-0d1e-2f3a4b5c6d7e',
    'Problema con la configuración de idioma',
    E'El sistema no guarda mi preferencia de idioma español.',
    'pending',
    'low',
    ARRAY['language', 'settings', 'spanish'],
    '{"preferred_language": "es"}'::jsonb,
    '{
        "events": [
            {
                "id": "550e8400-e29b-41d4-a716-446655440012",
                "type": "message",
                "content": "El sistema no guarda mi preferencia de idioma español.",
                "created_at": "2024-12-10T10:00:00Z",
                "created_by_uuid": "7d3e41c9-9a5d-4e4f-a71c-94b17e8f6e24",
                "created_by_first_name": "Carlos",
                "created_by_last_name": "Garcia",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440013",
                "type": "assignment-added",
                "agent_id": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab",
                "created_at": "2024-12-10T10:05:00Z",
                "created_by_uuid": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab",
                "created_by_first_name": "James",
                "created_by_last_name": "Martinez",
                "visibility": "public"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440014",
                "type": "field-added",
                "field_name": "language",
                "new_value": "es",
                "created_at": "2024-12-10T10:06:00Z",
                "created_by_uuid": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab",
                "created_by_first_name": "James",
                "created_by_last_name": "Martinez",
                "visibility": "private"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440015",
                "type": "status-update",
                "old_value": "new",
                "new_value": "pending",
                "created_at": "2024-12-10T10:07:00Z",
                "created_by_uuid": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab",
                "created_by_first_name": "James",
                "created_by_last_name": "Martinez",
                "visibility": "public"
            }
        ]
    }'::jsonb,
    '{
        "notes": [
            {
                "id": "note2",
                "content": "User experiencing persistent language setting issues",
                "created_at": "2024-12-10T10:07:00Z",
                "created_by": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab"
            }
        ]
    }'::jsonb,
    '{
        "rating": 3,
        "comment": "Servicio regular, problemas de idioma",
        "submitted_at": "2024-12-10T10:08:00Z"
    }'::jsonb,
    'email',
    now() - interval '54 days',
    now() - interval '54 days',
    '7d3e41c9-9a5d-4e4f-a71c-94b17e8f6e24',
    'carlos.garcia@example.com',
    '[]'::jsonb
);

-- Ticket 4: Open ticket from John Doe
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    '9a0b1c2d-3e4f-5a6b-7c8d-9e0f1a2b3c4d',
    'Need help with API integration',
    'Looking for documentation about API integration with your service.',
    'open',
    'medium',
    ARRAY['api', 'integration', 'documentation'],
    '{}',
    '{
        "events": [
            {
                "id": "550e8400-e29b-41d4-a716-446655440016",
                "type": "message",
                "content": "Need help finding API documentation",
                "created_at": "2024-01-20T10:00:00Z",
                "created_by_uuid": "a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f",
                "created_by_first_name": "John",
                "created_by_last_name": "Doe",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440017",
                "type": "message",
                "content": "Hi John! You can find our API documentation at docs.example.com/api. Is there a specific endpoint you''re looking for?",
                "created_at": "2024-01-20T10:05:00Z",
                "created_by_uuid": "7a1b5e4c-2d3f-6789-9012-1a2b3c4d5e6f",
                "created_by_first_name": "Alex",
                "created_by_last_name": "Chen",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440018",
                "type": "message",
                "content": "Yes, I''m specifically looking for the user management endpoints.",
                "created_at": "2024-01-20T10:07:00Z",
                "created_by_uuid": "a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f",
                "created_by_first_name": "John",
                "created_by_last_name": "Doe",
                "visibility": "public",
                "attachments": []
            }
        ]
    }'::jsonb,
    '{"notes": []}'::jsonb,
    '{"rating": 0, "comment": "", "submitted_at": null}'::jsonb,
    'web',
    now() - interval '1 day',
    now() - interval '1 day',
    'a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f',
    'john.doe@example.com',
    '[]'::jsonb
);

-- Ticket 5: Complex ticket from Emma Wilson
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    '4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a',
    'Feature request: Enhanced reporting',
    'Would love to see more detailed analytics in the reporting dashboard.',
    'closed',
    'low',
    ARRAY['feature-request', 'analytics', 'reporting'],
    '{"feature_category": "analytics", "user_type": "premium"}',
    '{
        "events": [
            {
                "id": "550e8400-e29b-41d4-a716-446655440019",
                "type": "message",
                "content": "Hi! I''d love to see more detailed analytics in the reporting dashboard. Specifically, we need better insights into user engagement patterns and custom event tracking.",
                "created_at": "2024-12-10T13:30:00Z",
                "created_by_uuid": "b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9",
                "created_by_first_name": "Emma",
                "created_by_last_name": "Wilson",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440020",
                "type": "message",
                "content": "Hi Emma! Thank you for the suggestion. Could you tell us more about the specific metrics you''d like to track?",
                "created_at": "2024-12-10T13:35:00Z",
                "created_by_uuid": "2c9a7d31-4e8f-42b5-9d63-8f7a1b5e4c2d",
                "created_by_first_name": "Mike",
                "created_by_last_name": "Williams",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440021",
                "type": "message",
                "content": "We''d like to track user session duration, conversion funnels, and feature adoption rates. It would be great to see how different features correlate with user engagement.",
                "created_at": "2024-12-10T13:38:00Z",
                "created_by_uuid": "b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9",
                "created_by_first_name": "Emma",
                "created_by_last_name": "Wilson",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440022",
                "type": "status-update",
                "old_value": "new",
                "new_value": "open",
                "created_at": "2024-12-10T13:40:00Z",
                "created_by_uuid": "2c9a7d31-4e8f-42b5-9d63-8f7a1b5e4c2d",
                "created_by_first_name": "Mike",
                "created_by_last_name": "Williams",
                "visibility": "public"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440023",
                "type": "message",
                "content": "Great feedback! I''m happy to share that these features are already on our Q1 2024 roadmap. Would you be interested in joining our beta testing program?",
                "created_at": "2024-12-10T13:42:00Z",
                "created_by_uuid": "2c9a7d31-4e8f-42b5-9d63-8f7a1b5e4c2d",
                "created_by_first_name": "Mike",
                "created_by_last_name": "Williams",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440024",
                "type": "message",
                "content": "Yes, definitely! Please add me to the beta testing group.",
                "created_at": "2024-12-10T13:43:00Z",
                "created_by_uuid": "b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9",
                "created_by_first_name": "Emma",
                "created_by_last_name": "Wilson",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440025",
                "type": "status-update",
                "old_value": "open",
                "new_value": "closed",
                "created_at": "2024-12-10T13:45:00Z",
                "created_by_uuid": "2c9a7d31-4e8f-42b5-9d63-8f7a1b5e4c2d",
                "created_by_first_name": "Mike",
                "created_by_last_name": "Williams",
                "visibility": "public"
            }
        ]
    }'::jsonb,
    '{
        "notes": [
            {
                "id": "note3",
                "content": "Valid feature request - added to product backlog",
                "created_at": "2024-12-10T13:42:00Z",
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58"
            }
        ]
    }'::jsonb,
    '{
        "rating": 5,
        "comment": "Very helpful team",
        "submitted_at": "2024-12-10T13:45:00Z"
    }'::jsonb,
    'web',
    now() - interval '42 days',
    now() - interval '42 days',
    'b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9',
    'emma.wilson@example.com',
    '[]'::jsonb
);
