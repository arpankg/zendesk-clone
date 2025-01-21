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
                "id": "evt-1a",
                "type": "message",
                "content": "I am unable to access my dashboard after logging in",
                "created_at": "2024-12-20T14:25:00Z",
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
                "visibility": "public",
                "attachments": []
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
                "id": "evt-2a",
                "type": "message",
                "content": "I have questions about premium plan pricing",
                "created_at": "2024-12-15T09:00:00Z",
                "created_by": "f23c5c88-2322-4c2d-9f59-43e79a9b5c44",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "evt-2b",
                "type": "message",
                "content": "Here are the premium plan details...",
                "created_at": "2024-12-15T09:10:00Z",
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "evt-2c",
                "type": "status-update",
                "old_value": "new",
                "new_value": "closed",
                "created_at": "2024-12-15T09:15:00Z",
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
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
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58"
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
    'El sistema no guarda mi preferencia de idioma español.',
    'pending',
    'low',
    ARRAY['language', 'settings', 'spanish'],
    '{"preferred_language": "es"}',
    '{
        "events": [
            {
                "id": "evt-3a",
                "type": "message",
                "content": "El sistema no guarda mi preferencia de idioma",
                "created_at": "2024-11-28T16:30:00Z",
                "created_by": "7d3e41c9-9a5d-4e4f-a71c-94b17e8f6e24",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "evt-3b",
                "type": "message",
                "content": "Por favor, intente borrar la caché...",
                "created_at": "2024-11-28T16:40:00Z",
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "evt-3c",
                "type": "status-update",
                "old_value": "new",
                "new_value": "pending",
                "created_at": "2024-11-28T16:42:00Z",
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
                "visibility": "public"
            }
        ]
    }'::jsonb,
    '{
        "notes": [
            {
                "id": "note2",
                "content": "User experiencing persistent language setting issues",
                "created_at": "2024-11-28T16:42:00Z",
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58"
            }
        ]
    }'::jsonb,
    '{
        "rating": 3,
        "comment": "Servicio regular, problemas de idioma",
        "submitted_at": "2024-11-28T16:45:00Z"
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
                "id": "evt-4a",
                "type": "message",
                "content": "Need help finding API documentation",
                "created_at": "2024-01-20T10:00:00Z",
                "created_by": "a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "evt-4b",
                "type": "status-update",
                "old_value": "new",
                "new_value": "open",
                "created_at": "2024-01-20T10:05:00Z",
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
                "visibility": "public"
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
                "id": "evt-5a",
                "type": "message",
                "content": "Requesting enhanced reporting features",
                "created_at": "2024-12-10T13:30:00Z",
                "created_by": "b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "evt-5b",
                "type": "message",
                "content": "Thanks for the suggestion! We''ll add this to our roadmap.",
                "created_at": "2024-12-10T13:40:00Z",
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "evt-5c",
                "type": "field-added",
                "field_name": "feature_category",
                "new_value": "analytics",
                "created_at": "2024-12-10T13:41:00Z",
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
                "visibility": "private"
            },
            {
                "id": "evt-5d",
                "type": "status-update",
                "old_value": "new",
                "new_value": "closed",
                "created_at": "2024-12-10T13:42:00Z",
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
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
