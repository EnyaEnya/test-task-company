--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+1)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-1.pgdg22.04+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: org; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000)
);


ALTER TABLE public.org OWNER TO keycloak;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
ad22d6a7-f9aa-4f40-88c8-4f8e40e20c4f	\N	auth-cookie	1188f655-9676-4630-ba0e-451e8cbc5697	171e9df6-a7b8-46c9-bc61-6520359f744a	2	10	f	\N	\N
4b4c7cac-a948-42f4-826e-7f5af3bbced8	\N	auth-spnego	1188f655-9676-4630-ba0e-451e8cbc5697	171e9df6-a7b8-46c9-bc61-6520359f744a	3	20	f	\N	\N
6a990ff1-a2ee-4616-ba8d-9ebce7e45838	\N	identity-provider-redirector	1188f655-9676-4630-ba0e-451e8cbc5697	171e9df6-a7b8-46c9-bc61-6520359f744a	2	25	f	\N	\N
20f0b65e-3315-4958-bb56-240bffce3eae	\N	\N	1188f655-9676-4630-ba0e-451e8cbc5697	171e9df6-a7b8-46c9-bc61-6520359f744a	2	30	t	0ed85125-e1d9-4f8e-bdde-c74b196c81f5	\N
36f8b9c0-5d4f-46b9-9dbd-7d43c2074f8b	\N	auth-username-password-form	1188f655-9676-4630-ba0e-451e8cbc5697	0ed85125-e1d9-4f8e-bdde-c74b196c81f5	0	10	f	\N	\N
62949187-a9d4-43b6-9e06-19432e65a899	\N	\N	1188f655-9676-4630-ba0e-451e8cbc5697	0ed85125-e1d9-4f8e-bdde-c74b196c81f5	1	20	t	163bd77a-acc1-4823-b690-066009106604	\N
284fe150-85d6-4f8a-94ce-1ae529e4e7de	\N	conditional-user-configured	1188f655-9676-4630-ba0e-451e8cbc5697	163bd77a-acc1-4823-b690-066009106604	0	10	f	\N	\N
18c51983-7257-402d-9318-74e3ec6278ae	\N	auth-otp-form	1188f655-9676-4630-ba0e-451e8cbc5697	163bd77a-acc1-4823-b690-066009106604	0	20	f	\N	\N
a9085cb5-192d-4250-aa17-ebbe6d795e0e	\N	direct-grant-validate-username	1188f655-9676-4630-ba0e-451e8cbc5697	ee3b6286-0e37-47e4-8895-88ea7667fb1d	0	10	f	\N	\N
0c7ffbf1-19de-4775-96de-25bbfdbc20ed	\N	direct-grant-validate-password	1188f655-9676-4630-ba0e-451e8cbc5697	ee3b6286-0e37-47e4-8895-88ea7667fb1d	0	20	f	\N	\N
c4299365-1a22-4df0-8977-3418458209ff	\N	\N	1188f655-9676-4630-ba0e-451e8cbc5697	ee3b6286-0e37-47e4-8895-88ea7667fb1d	1	30	t	1d77d91b-ce04-41e8-be0a-d69f7a109ec1	\N
1386d079-a715-4200-8e90-5d8e2501dbca	\N	conditional-user-configured	1188f655-9676-4630-ba0e-451e8cbc5697	1d77d91b-ce04-41e8-be0a-d69f7a109ec1	0	10	f	\N	\N
86832176-df43-4dfe-ae35-3224a0f9ca4a	\N	direct-grant-validate-otp	1188f655-9676-4630-ba0e-451e8cbc5697	1d77d91b-ce04-41e8-be0a-d69f7a109ec1	0	20	f	\N	\N
33100256-d336-46e3-8c41-a2548de100bd	\N	registration-page-form	1188f655-9676-4630-ba0e-451e8cbc5697	9f77e263-b0d7-49ba-b0ac-ee76e8f5a58e	0	10	t	7f3c9bf1-7035-44cb-b5ef-6f447f22790a	\N
a74a3884-09bc-4a70-9940-cf427a14e7a8	\N	registration-user-creation	1188f655-9676-4630-ba0e-451e8cbc5697	7f3c9bf1-7035-44cb-b5ef-6f447f22790a	0	20	f	\N	\N
ee6d8235-fbcd-4e2f-aafa-f627c007da8d	\N	registration-password-action	1188f655-9676-4630-ba0e-451e8cbc5697	7f3c9bf1-7035-44cb-b5ef-6f447f22790a	0	50	f	\N	\N
a0a18e47-04f1-427e-92b4-14857e8cb2c1	\N	registration-recaptcha-action	1188f655-9676-4630-ba0e-451e8cbc5697	7f3c9bf1-7035-44cb-b5ef-6f447f22790a	3	60	f	\N	\N
c75e768d-0a6c-4779-a680-aaf5bc2b09e5	\N	registration-terms-and-conditions	1188f655-9676-4630-ba0e-451e8cbc5697	7f3c9bf1-7035-44cb-b5ef-6f447f22790a	3	70	f	\N	\N
82e9338a-968c-4a93-8704-a8d9b06384f3	\N	reset-credentials-choose-user	1188f655-9676-4630-ba0e-451e8cbc5697	46f35fd4-e8d7-4c11-8e38-eb72b7a17e14	0	10	f	\N	\N
8a4b1791-d761-42e7-b610-500bb578265f	\N	reset-credential-email	1188f655-9676-4630-ba0e-451e8cbc5697	46f35fd4-e8d7-4c11-8e38-eb72b7a17e14	0	20	f	\N	\N
05f61b93-0341-4091-b64c-f3eacc2ab9b2	\N	reset-password	1188f655-9676-4630-ba0e-451e8cbc5697	46f35fd4-e8d7-4c11-8e38-eb72b7a17e14	0	30	f	\N	\N
b03fb666-e0f4-4419-8de1-1b8baa357b88	\N	\N	1188f655-9676-4630-ba0e-451e8cbc5697	46f35fd4-e8d7-4c11-8e38-eb72b7a17e14	1	40	t	e4e2edb4-1c2f-4800-8ed4-aea270e1c46e	\N
7fc7c6e6-228c-48a0-9d12-1287910c9d7b	\N	conditional-user-configured	1188f655-9676-4630-ba0e-451e8cbc5697	e4e2edb4-1c2f-4800-8ed4-aea270e1c46e	0	10	f	\N	\N
75bb90b9-c041-496e-8346-462821ebbd97	\N	reset-otp	1188f655-9676-4630-ba0e-451e8cbc5697	e4e2edb4-1c2f-4800-8ed4-aea270e1c46e	0	20	f	\N	\N
a6f2b79d-cdc3-4701-ac10-b98c828d817d	\N	client-secret	1188f655-9676-4630-ba0e-451e8cbc5697	75daa8f0-22ef-4466-8d59-9a58ee74c1fb	2	10	f	\N	\N
974ca3c9-d68c-473c-bf63-a345d82e493d	\N	client-jwt	1188f655-9676-4630-ba0e-451e8cbc5697	75daa8f0-22ef-4466-8d59-9a58ee74c1fb	2	20	f	\N	\N
047cd524-82e2-4df1-8939-9fce6bbe730a	\N	client-secret-jwt	1188f655-9676-4630-ba0e-451e8cbc5697	75daa8f0-22ef-4466-8d59-9a58ee74c1fb	2	30	f	\N	\N
1272371c-8ed4-44fb-b8f7-2eedad55d596	\N	client-x509	1188f655-9676-4630-ba0e-451e8cbc5697	75daa8f0-22ef-4466-8d59-9a58ee74c1fb	2	40	f	\N	\N
ff7bf9bc-f944-4033-ba01-22833eefa49f	\N	idp-review-profile	1188f655-9676-4630-ba0e-451e8cbc5697	3c6f183c-6045-4676-9212-05c783706d1c	0	10	f	\N	e3cf3a8a-3523-445d-a034-c31d2d025f02
9ee6e08d-8420-4764-9d8c-367911c3b795	\N	\N	1188f655-9676-4630-ba0e-451e8cbc5697	3c6f183c-6045-4676-9212-05c783706d1c	0	20	t	207c2296-1f9d-43c0-94e2-6cbd02657006	\N
c0e8b9b0-7508-456c-b7b8-50c39f05013a	\N	idp-create-user-if-unique	1188f655-9676-4630-ba0e-451e8cbc5697	207c2296-1f9d-43c0-94e2-6cbd02657006	2	10	f	\N	78097299-39cd-4b18-a10b-2f15e818c900
5bffaf6e-41b3-4edb-af54-0c5cfebfadf9	\N	\N	1188f655-9676-4630-ba0e-451e8cbc5697	207c2296-1f9d-43c0-94e2-6cbd02657006	2	20	t	b076da54-e963-4598-969b-ae8fb16c88b0	\N
6d8f01d8-1e46-491e-9962-1825517527f1	\N	idp-confirm-link	1188f655-9676-4630-ba0e-451e8cbc5697	b076da54-e963-4598-969b-ae8fb16c88b0	0	10	f	\N	\N
1936596a-351a-44ad-ba7a-5e1664afd627	\N	\N	1188f655-9676-4630-ba0e-451e8cbc5697	b076da54-e963-4598-969b-ae8fb16c88b0	0	20	t	2df65071-ba37-480b-83d4-86111711b866	\N
969fc63d-6f04-49c8-9d1b-aeaed486314a	\N	idp-email-verification	1188f655-9676-4630-ba0e-451e8cbc5697	2df65071-ba37-480b-83d4-86111711b866	2	10	f	\N	\N
b8b88a30-42de-4ef3-9607-470e5ac7c8d9	\N	\N	1188f655-9676-4630-ba0e-451e8cbc5697	2df65071-ba37-480b-83d4-86111711b866	2	20	t	aae063c3-564b-45ed-8a1f-51887173223f	\N
2802ba5f-c2f5-4749-8e4d-0a790f3c9707	\N	idp-username-password-form	1188f655-9676-4630-ba0e-451e8cbc5697	aae063c3-564b-45ed-8a1f-51887173223f	0	10	f	\N	\N
7dc2be72-0f8e-4c38-a96c-deeee371ce5b	\N	\N	1188f655-9676-4630-ba0e-451e8cbc5697	aae063c3-564b-45ed-8a1f-51887173223f	1	20	t	1d67e37b-dea1-4218-b4de-e30420e97475	\N
eb96133b-9b5b-4284-907a-427cb477db20	\N	conditional-user-configured	1188f655-9676-4630-ba0e-451e8cbc5697	1d67e37b-dea1-4218-b4de-e30420e97475	0	10	f	\N	\N
d3961114-3137-44fc-923f-c0d81b5c2b4e	\N	auth-otp-form	1188f655-9676-4630-ba0e-451e8cbc5697	1d67e37b-dea1-4218-b4de-e30420e97475	0	20	f	\N	\N
1e9e5983-4035-4de5-bfff-ddaf97ee44d2	\N	http-basic-authenticator	1188f655-9676-4630-ba0e-451e8cbc5697	a209ddfd-d574-432b-9f36-a6116b093a28	0	10	f	\N	\N
64136e8f-4778-4244-b85a-0c7c5c3694c2	\N	docker-http-basic-authenticator	1188f655-9676-4630-ba0e-451e8cbc5697	5bf24d8f-6937-4804-b6ae-761230fe0c70	0	10	f	\N	\N
44ffdb44-bda0-441c-bbb5-a9aea2edf3bf	\N	idp-email-verification	0ff635a9-4a9c-47af-8eec-860d88e871e8	e5fe38b9-ed1a-43ec-9da1-76b60828cc39	2	10	f	\N	\N
90a98d33-d064-46e5-a26e-f87d0dc58665	\N	\N	0ff635a9-4a9c-47af-8eec-860d88e871e8	e5fe38b9-ed1a-43ec-9da1-76b60828cc39	2	20	t	5ca1db38-eeeb-4a8c-a601-bd1c9cc73cae	\N
660e3117-a1a7-47b1-9178-3237216a56ef	\N	conditional-user-configured	0ff635a9-4a9c-47af-8eec-860d88e871e8	382857eb-e5f3-4151-95c4-c60267ddbf94	0	10	f	\N	\N
a17d1e5a-c0cf-4a69-a701-b5819ab96c8f	\N	auth-otp-form	0ff635a9-4a9c-47af-8eec-860d88e871e8	382857eb-e5f3-4151-95c4-c60267ddbf94	0	20	f	\N	\N
8ef56b0d-00e0-4c5b-ba37-e507198c04d3	\N	conditional-user-configured	0ff635a9-4a9c-47af-8eec-860d88e871e8	abde928c-5f6d-425c-8837-edf196342045	0	10	f	\N	\N
72524f48-7bec-47c0-885f-dff2783305e8	\N	direct-grant-validate-otp	0ff635a9-4a9c-47af-8eec-860d88e871e8	abde928c-5f6d-425c-8837-edf196342045	0	20	f	\N	\N
eab67d87-35c8-4811-8782-6175c948d286	\N	conditional-user-configured	0ff635a9-4a9c-47af-8eec-860d88e871e8	6bd6ba94-6e72-4d91-953d-55cffc9c3079	0	10	f	\N	\N
06fb1609-340b-4155-9451-fbf9d9dd5854	\N	auth-otp-form	0ff635a9-4a9c-47af-8eec-860d88e871e8	6bd6ba94-6e72-4d91-953d-55cffc9c3079	0	20	f	\N	\N
8af38676-8d3c-465b-989a-edbd8e13fbf9	\N	idp-confirm-link	0ff635a9-4a9c-47af-8eec-860d88e871e8	91921e5b-b875-44ee-af4f-7657350bdb7e	0	10	f	\N	\N
8ae718a3-f847-4a68-87ff-f99b833bdb70	\N	\N	0ff635a9-4a9c-47af-8eec-860d88e871e8	91921e5b-b875-44ee-af4f-7657350bdb7e	0	20	t	e5fe38b9-ed1a-43ec-9da1-76b60828cc39	\N
b7cfd358-dec5-4bfe-aac5-6c04a00f965c	\N	conditional-user-configured	0ff635a9-4a9c-47af-8eec-860d88e871e8	3dc23649-3787-4203-b065-a156eccf8003	0	10	f	\N	\N
21c01a13-06f7-4899-a8d7-17e38cbde4fe	\N	reset-otp	0ff635a9-4a9c-47af-8eec-860d88e871e8	3dc23649-3787-4203-b065-a156eccf8003	0	20	f	\N	\N
fe18abe1-7cb7-4fe5-90da-0182ba94d3a3	\N	idp-create-user-if-unique	0ff635a9-4a9c-47af-8eec-860d88e871e8	4dc450d8-f8c3-4276-9bf9-2dad78a9b556	2	10	f	\N	0c7765a4-c23c-4d46-adfa-84f4eaf3a576
ec77bb96-43b4-42d6-8e52-fccf91a46503	\N	\N	0ff635a9-4a9c-47af-8eec-860d88e871e8	4dc450d8-f8c3-4276-9bf9-2dad78a9b556	2	20	t	91921e5b-b875-44ee-af4f-7657350bdb7e	\N
a11b42ec-f38d-47af-9d7a-5eb9320dcf19	\N	idp-username-password-form	0ff635a9-4a9c-47af-8eec-860d88e871e8	5ca1db38-eeeb-4a8c-a601-bd1c9cc73cae	0	10	f	\N	\N
987c034b-a6f5-4a85-b6e3-d64531ba7509	\N	\N	0ff635a9-4a9c-47af-8eec-860d88e871e8	5ca1db38-eeeb-4a8c-a601-bd1c9cc73cae	1	20	t	6bd6ba94-6e72-4d91-953d-55cffc9c3079	\N
1b283e16-205e-4735-8b5d-ec908d777536	\N	auth-cookie	0ff635a9-4a9c-47af-8eec-860d88e871e8	e4b7aebc-54f8-4a49-8aea-58605e34d8c8	2	10	f	\N	\N
4893f5a2-57d0-4313-9a4f-9c619b85cb2f	\N	auth-spnego	0ff635a9-4a9c-47af-8eec-860d88e871e8	e4b7aebc-54f8-4a49-8aea-58605e34d8c8	3	20	f	\N	\N
aa00c606-5e5e-48cd-b7fe-848c2cfd64f4	\N	identity-provider-redirector	0ff635a9-4a9c-47af-8eec-860d88e871e8	e4b7aebc-54f8-4a49-8aea-58605e34d8c8	2	25	f	\N	\N
7b0175f2-f7e7-4738-97c3-f64d5afaf491	\N	\N	0ff635a9-4a9c-47af-8eec-860d88e871e8	e4b7aebc-54f8-4a49-8aea-58605e34d8c8	2	30	t	05f806e6-be26-4c8a-a589-4ab2d98e5c44	\N
5963cddd-a335-47eb-9edb-a24634414d87	\N	client-secret	0ff635a9-4a9c-47af-8eec-860d88e871e8	40ca7d73-264f-4031-89be-3a610dfab4d4	2	10	f	\N	\N
804f9241-5d9b-450e-8a59-1868dfb524bd	\N	client-jwt	0ff635a9-4a9c-47af-8eec-860d88e871e8	40ca7d73-264f-4031-89be-3a610dfab4d4	2	20	f	\N	\N
179a796b-c42a-4411-948d-983071298838	\N	client-secret-jwt	0ff635a9-4a9c-47af-8eec-860d88e871e8	40ca7d73-264f-4031-89be-3a610dfab4d4	2	30	f	\N	\N
3e4faf57-267b-4d2d-9868-8f37eb4e634d	\N	client-x509	0ff635a9-4a9c-47af-8eec-860d88e871e8	40ca7d73-264f-4031-89be-3a610dfab4d4	2	40	f	\N	\N
717be3c9-b0bb-4703-a8ff-7e88c1cebba2	\N	direct-grant-validate-username	0ff635a9-4a9c-47af-8eec-860d88e871e8	8c209791-2d9c-4250-9c20-fccacd3e56cb	0	10	f	\N	\N
fa13fcdd-f6eb-45e0-bada-0ee07e77e00e	\N	direct-grant-validate-password	0ff635a9-4a9c-47af-8eec-860d88e871e8	8c209791-2d9c-4250-9c20-fccacd3e56cb	0	20	f	\N	\N
490b803a-73ac-4007-936c-8e506b0e7b67	\N	\N	0ff635a9-4a9c-47af-8eec-860d88e871e8	8c209791-2d9c-4250-9c20-fccacd3e56cb	1	30	t	abde928c-5f6d-425c-8837-edf196342045	\N
14f81922-e41f-4d25-87de-5b15b4204acb	\N	docker-http-basic-authenticator	0ff635a9-4a9c-47af-8eec-860d88e871e8	f5b6a48a-a1c6-4b30-879c-e2be53b4b78e	0	10	f	\N	\N
ff79e29b-e048-4685-9c1b-06284a36483a	\N	idp-review-profile	0ff635a9-4a9c-47af-8eec-860d88e871e8	66390e1e-f83e-489a-84e3-790d4a27433f	0	10	f	\N	b693b9df-51a4-46c6-b0a1-4d501c9b19c9
8d2fc99e-8553-4e71-b6f9-184082ef15b9	\N	\N	0ff635a9-4a9c-47af-8eec-860d88e871e8	66390e1e-f83e-489a-84e3-790d4a27433f	0	20	t	4dc450d8-f8c3-4276-9bf9-2dad78a9b556	\N
40cb8228-d732-45c9-a777-6cfbf2ad9008	\N	auth-username-password-form	0ff635a9-4a9c-47af-8eec-860d88e871e8	05f806e6-be26-4c8a-a589-4ab2d98e5c44	0	10	f	\N	\N
b5326ccd-e467-45ef-9f52-757f1e80aeb7	\N	\N	0ff635a9-4a9c-47af-8eec-860d88e871e8	05f806e6-be26-4c8a-a589-4ab2d98e5c44	1	20	t	382857eb-e5f3-4151-95c4-c60267ddbf94	\N
8a94b8a0-7be8-479f-a480-2d74c2d6ee5e	\N	registration-page-form	0ff635a9-4a9c-47af-8eec-860d88e871e8	b89a445f-102f-42e9-9c16-b1c37f746b91	0	10	t	286510a9-a940-401c-b09c-09f0e852c496	\N
4b1bb0a5-b4eb-4625-9633-33b60f5a760b	\N	registration-user-creation	0ff635a9-4a9c-47af-8eec-860d88e871e8	286510a9-a940-401c-b09c-09f0e852c496	0	20	f	\N	\N
17bb8b42-0099-4dad-93c3-f0999a6058af	\N	registration-password-action	0ff635a9-4a9c-47af-8eec-860d88e871e8	286510a9-a940-401c-b09c-09f0e852c496	0	50	f	\N	\N
966eb797-2974-4edf-9957-87461652c30b	\N	registration-recaptcha-action	0ff635a9-4a9c-47af-8eec-860d88e871e8	286510a9-a940-401c-b09c-09f0e852c496	3	60	f	\N	\N
91f00e85-2303-4fba-b1f7-3282316c12e7	\N	reset-credentials-choose-user	0ff635a9-4a9c-47af-8eec-860d88e871e8	63e93642-eee9-45d4-a862-852306f6d678	0	10	f	\N	\N
06017554-8dd0-4d1c-b26b-fe3af6aa3aa4	\N	reset-credential-email	0ff635a9-4a9c-47af-8eec-860d88e871e8	63e93642-eee9-45d4-a862-852306f6d678	0	20	f	\N	\N
f31c356a-7ed2-41f4-91ab-feb6156bb974	\N	reset-password	0ff635a9-4a9c-47af-8eec-860d88e871e8	63e93642-eee9-45d4-a862-852306f6d678	0	30	f	\N	\N
9ed009e3-6952-47be-a134-292386e3d65b	\N	\N	0ff635a9-4a9c-47af-8eec-860d88e871e8	63e93642-eee9-45d4-a862-852306f6d678	1	40	t	3dc23649-3787-4203-b065-a156eccf8003	\N
5b7bfdc0-436c-4eb0-a7e5-8e1df40ed785	\N	http-basic-authenticator	0ff635a9-4a9c-47af-8eec-860d88e871e8	f6335e05-0d81-42ce-bd84-fa638029c240	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
171e9df6-a7b8-46c9-bc61-6520359f744a	browser	browser based authentication	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	t	t
0ed85125-e1d9-4f8e-bdde-c74b196c81f5	forms	Username, password, otp and other auth forms.	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	f	t
163bd77a-acc1-4823-b690-066009106604	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	f	t
ee3b6286-0e37-47e4-8895-88ea7667fb1d	direct grant	OpenID Connect Resource Owner Grant	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	t	t
1d77d91b-ce04-41e8-be0a-d69f7a109ec1	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	f	t
9f77e263-b0d7-49ba-b0ac-ee76e8f5a58e	registration	registration flow	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	t	t
7f3c9bf1-7035-44cb-b5ef-6f447f22790a	registration form	registration form	1188f655-9676-4630-ba0e-451e8cbc5697	form-flow	f	t
46f35fd4-e8d7-4c11-8e38-eb72b7a17e14	reset credentials	Reset credentials for a user if they forgot their password or something	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	t	t
e4e2edb4-1c2f-4800-8ed4-aea270e1c46e	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	f	t
75daa8f0-22ef-4466-8d59-9a58ee74c1fb	clients	Base authentication for clients	1188f655-9676-4630-ba0e-451e8cbc5697	client-flow	t	t
3c6f183c-6045-4676-9212-05c783706d1c	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	t	t
207c2296-1f9d-43c0-94e2-6cbd02657006	User creation or linking	Flow for the existing/non-existing user alternatives	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	f	t
b076da54-e963-4598-969b-ae8fb16c88b0	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	f	t
2df65071-ba37-480b-83d4-86111711b866	Account verification options	Method with which to verity the existing account	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	f	t
aae063c3-564b-45ed-8a1f-51887173223f	Verify Existing Account by Re-authentication	Reauthentication of existing account	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	f	t
1d67e37b-dea1-4218-b4de-e30420e97475	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	f	t
a209ddfd-d574-432b-9f36-a6116b093a28	saml ecp	SAML ECP Profile Authentication Flow	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	t	t
5bf24d8f-6937-4804-b6ae-761230fe0c70	docker auth	Used by Docker clients to authenticate against the IDP	1188f655-9676-4630-ba0e-451e8cbc5697	basic-flow	t	t
e5fe38b9-ed1a-43ec-9da1-76b60828cc39	Account verification options	Method with which to verity the existing account	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	f	t
382857eb-e5f3-4151-95c4-c60267ddbf94	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	f	t
abde928c-5f6d-425c-8837-edf196342045	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	f	t
6bd6ba94-6e72-4d91-953d-55cffc9c3079	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	f	t
91921e5b-b875-44ee-af4f-7657350bdb7e	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	f	t
3dc23649-3787-4203-b065-a156eccf8003	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	f	t
4dc450d8-f8c3-4276-9bf9-2dad78a9b556	User creation or linking	Flow for the existing/non-existing user alternatives	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	f	t
5ca1db38-eeeb-4a8c-a601-bd1c9cc73cae	Verify Existing Account by Re-authentication	Reauthentication of existing account	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	f	t
e4b7aebc-54f8-4a49-8aea-58605e34d8c8	browser	browser based authentication	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	t	t
40ca7d73-264f-4031-89be-3a610dfab4d4	clients	Base authentication for clients	0ff635a9-4a9c-47af-8eec-860d88e871e8	client-flow	t	t
8c209791-2d9c-4250-9c20-fccacd3e56cb	direct grant	OpenID Connect Resource Owner Grant	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	t	t
f5b6a48a-a1c6-4b30-879c-e2be53b4b78e	docker auth	Used by Docker clients to authenticate against the IDP	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	t	t
66390e1e-f83e-489a-84e3-790d4a27433f	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	t	t
05f806e6-be26-4c8a-a589-4ab2d98e5c44	forms	Username, password, otp and other auth forms.	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	f	t
b89a445f-102f-42e9-9c16-b1c37f746b91	registration	registration flow	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	t	t
286510a9-a940-401c-b09c-09f0e852c496	registration form	registration form	0ff635a9-4a9c-47af-8eec-860d88e871e8	form-flow	f	t
63e93642-eee9-45d4-a862-852306f6d678	reset credentials	Reset credentials for a user if they forgot their password or something	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	t	t
f6335e05-0d81-42ce-bd84-fa638029c240	saml ecp	SAML ECP Profile Authentication Flow	0ff635a9-4a9c-47af-8eec-860d88e871e8	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
e3cf3a8a-3523-445d-a034-c31d2d025f02	review profile config	1188f655-9676-4630-ba0e-451e8cbc5697
78097299-39cd-4b18-a10b-2f15e818c900	create unique user config	1188f655-9676-4630-ba0e-451e8cbc5697
0c7765a4-c23c-4d46-adfa-84f4eaf3a576	create unique user config	0ff635a9-4a9c-47af-8eec-860d88e871e8
b693b9df-51a4-46c6-b0a1-4d501c9b19c9	review profile config	0ff635a9-4a9c-47af-8eec-860d88e871e8
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
78097299-39cd-4b18-a10b-2f15e818c900	false	require.password.update.after.registration
e3cf3a8a-3523-445d-a034-c31d2d025f02	missing	update.profile.on.first.login
0c7765a4-c23c-4d46-adfa-84f4eaf3a576	false	require.password.update.after.registration
b693b9df-51a4-46c6-b0a1-4d501c9b19c9	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
433248d8-6ac7-475a-a9cd-6a7977a2c034	t	f	master-realm	0	f	\N	\N	t	\N	f	1188f655-9676-4630-ba0e-451e8cbc5697	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
248766fb-d320-4a79-8a16-6567674baffd	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	1188f655-9676-4630-ba0e-451e8cbc5697	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	1188f655-9676-4630-ba0e-451e8cbc5697	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a6d97eed-774b-46cd-9d6b-05f70534bb6d	t	f	broker	0	f	\N	\N	t	\N	f	1188f655-9676-4630-ba0e-451e8cbc5697	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	1188f655-9676-4630-ba0e-451e8cbc5697	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
f7d3b0c2-4247-45b7-b45d-ba96cf20c450	t	f	admin-cli	0	t	\N	\N	f	\N	f	1188f655-9676-4630-ba0e-451e8cbc5697	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
0268cef5-ed1c-4f38-8eb1-675068670e01	t	f	TestCompanyRealm-realm	0	f	\N	\N	t	\N	f	1188f655-9676-4630-ba0e-451e8cbc5697	\N	0	f	f	TestCompanyRealm Realm	f	client-secret	\N	\N	\N	t	f	f	f
91089183-fce3-4047-a65d-ee0d02228343	t	f	account	0	t	\N	/realms/TestCompanyRealm/account/	f	\N	f	0ff635a9-4a9c-47af-8eec-860d88e871e8	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	t	f	account-console	0	t	\N	/realms/TestCompanyRealm/account/	f	\N	f	0ff635a9-4a9c-47af-8eec-860d88e871e8	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	t	f	admin-cli	0	f	16xbChzL0lwPNV232akR4n3HfUHFBSz4		f		f	0ff635a9-4a9c-47af-8eec-860d88e871e8	openid-connect	0	f	f	${client_admin-cli}	t	client-secret			\N	f	f	f	f
5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	t	f	broker	0	f	\N	\N	t	\N	f	0ff635a9-4a9c-47af-8eec-860d88e871e8	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	t	t	company	0	t	\N		f		f	0ff635a9-4a9c-47af-8eec-860d88e871e8	openid-connect	-1	t	f	Company	f	client-secret			\N	t	f	t	f
810f8ebf-9023-4c80-a734-65b7ee07eb63	t	f	realm-management	0	f	\N	\N	t	\N	f	0ff635a9-4a9c-47af-8eec-860d88e871e8	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
61ae9827-8300-4046-a78b-6fc1df466f66	t	f	security-admin-console	0	t	\N	/admin/TestCompanyRealm/console/	f	\N	f	0ff635a9-4a9c-47af-8eec-860d88e871e8	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
248766fb-d320-4a79-8a16-6567674baffd	post.logout.redirect.uris	+
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	post.logout.redirect.uris	+
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	pkce.code.challenge.method	S256
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	post.logout.redirect.uris	+
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	pkce.code.challenge.method	S256
91089183-fce3-4047-a65d-ee0d02228343	post.logout.redirect.uris	+
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	post.logout.redirect.uris	+
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	pkce.code.challenge.method	S256
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	oidc.ciba.grant.enabled	false
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	client.secret.creation.time	1730789460
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	backchannel.logout.session.required	true
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	post.logout.redirect.uris	+
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	display.on.consent.screen	false
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	oauth2.device.authorization.grant.enabled	false
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	backchannel.logout.revoke.offline.tokens	false
5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	post.logout.redirect.uris	+
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	oidc.ciba.grant.enabled	false
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	backchannel.logout.session.required	true
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	post.logout.redirect.uris	+
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	oauth2.device.authorization.grant.enabled	false
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	backchannel.logout.revoke.offline.tokens	false
810f8ebf-9023-4c80-a734-65b7ee07eb63	post.logout.redirect.uris	+
61ae9827-8300-4046-a78b-6fc1df466f66	post.logout.redirect.uris	+
61ae9827-8300-4046-a78b-6fc1df466f66	pkce.code.challenge.method	S256
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
8e239cf6-2408-4c62-bcf8-0d10acb2a45b	offline_access	1188f655-9676-4630-ba0e-451e8cbc5697	OpenID Connect built-in scope: offline_access	openid-connect
fa3b49a4-2e53-43be-9f98-1344e5d79207	role_list	1188f655-9676-4630-ba0e-451e8cbc5697	SAML role list	saml
b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9	profile	1188f655-9676-4630-ba0e-451e8cbc5697	OpenID Connect built-in scope: profile	openid-connect
f7ca2e9d-d959-41f6-8ab8-71703e1e09a6	email	1188f655-9676-4630-ba0e-451e8cbc5697	OpenID Connect built-in scope: email	openid-connect
279f3670-aa45-40a8-ab87-e1e987c131b5	address	1188f655-9676-4630-ba0e-451e8cbc5697	OpenID Connect built-in scope: address	openid-connect
0bbbf6cd-0807-45e6-8814-dfe44200f5a8	phone	1188f655-9676-4630-ba0e-451e8cbc5697	OpenID Connect built-in scope: phone	openid-connect
9ab24742-a022-47d1-ad7a-698eb22a2c90	roles	1188f655-9676-4630-ba0e-451e8cbc5697	OpenID Connect scope for add user roles to the access token	openid-connect
b4efce83-2cee-432d-9b8c-eddddbce074a	web-origins	1188f655-9676-4630-ba0e-451e8cbc5697	OpenID Connect scope for add allowed web origins to the access token	openid-connect
4ccf17fe-0bbb-4683-a121-19880aa8fd2d	microprofile-jwt	1188f655-9676-4630-ba0e-451e8cbc5697	Microprofile - JWT built-in scope	openid-connect
ac211429-43b9-43aa-81d7-a6c886641fa8	acr	1188f655-9676-4630-ba0e-451e8cbc5697	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
dc5cacff-c5cf-4fc2-8536-20b0fbbc1bee	basic	1188f655-9676-4630-ba0e-451e8cbc5697	OpenID Connect scope for add all basic claims to the token	openid-connect
41c99aee-bc3a-4911-92f6-19ea81a0b8c7	roles	0ff635a9-4a9c-47af-8eec-860d88e871e8	OpenID Connect scope for add user roles to the access token	openid-connect
3b5722d1-34d4-4b0a-884a-e72be27bc0e1	basic	0ff635a9-4a9c-47af-8eec-860d88e871e8	OpenID Connect scope for add all basic claims to the token	openid-connect
04804ea5-24cd-4ecd-a5ba-3c04b571642a	offline_access	0ff635a9-4a9c-47af-8eec-860d88e871e8	OpenID Connect built-in scope: offline_access	openid-connect
7ebc8ff0-51f5-4db3-acec-94465d76eacc	phone	0ff635a9-4a9c-47af-8eec-860d88e871e8	OpenID Connect built-in scope: phone	openid-connect
bb65e029-32ef-4b42-b112-da44ded26610	microprofile-jwt	0ff635a9-4a9c-47af-8eec-860d88e871e8	Microprofile - JWT built-in scope	openid-connect
dbcd7999-b789-420c-b217-77f23844ac15	web-origins	0ff635a9-4a9c-47af-8eec-860d88e871e8	OpenID Connect scope for add allowed web origins to the access token	openid-connect
5be4e042-446b-4ed0-9f16-d452e059de9d	acr	0ff635a9-4a9c-47af-8eec-860d88e871e8	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
e7947f94-14db-454c-9696-7dad601e9a77	role_list	0ff635a9-4a9c-47af-8eec-860d88e871e8	SAML role list	saml
286d34ba-2b51-4c9c-af5b-86a057aece86	profile	0ff635a9-4a9c-47af-8eec-860d88e871e8	OpenID Connect built-in scope: profile	openid-connect
24465872-0b69-4add-ae8f-1f99428eb6ba	email	0ff635a9-4a9c-47af-8eec-860d88e871e8	OpenID Connect built-in scope: email	openid-connect
f9fb13b2-0b16-40a9-bf29-3996c78a1daa	address	0ff635a9-4a9c-47af-8eec-860d88e871e8	OpenID Connect built-in scope: address	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
8e239cf6-2408-4c62-bcf8-0d10acb2a45b	true	display.on.consent.screen
8e239cf6-2408-4c62-bcf8-0d10acb2a45b	${offlineAccessScopeConsentText}	consent.screen.text
fa3b49a4-2e53-43be-9f98-1344e5d79207	true	display.on.consent.screen
fa3b49a4-2e53-43be-9f98-1344e5d79207	${samlRoleListScopeConsentText}	consent.screen.text
b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9	true	display.on.consent.screen
b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9	${profileScopeConsentText}	consent.screen.text
b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9	true	include.in.token.scope
f7ca2e9d-d959-41f6-8ab8-71703e1e09a6	true	display.on.consent.screen
f7ca2e9d-d959-41f6-8ab8-71703e1e09a6	${emailScopeConsentText}	consent.screen.text
f7ca2e9d-d959-41f6-8ab8-71703e1e09a6	true	include.in.token.scope
279f3670-aa45-40a8-ab87-e1e987c131b5	true	display.on.consent.screen
279f3670-aa45-40a8-ab87-e1e987c131b5	${addressScopeConsentText}	consent.screen.text
279f3670-aa45-40a8-ab87-e1e987c131b5	true	include.in.token.scope
0bbbf6cd-0807-45e6-8814-dfe44200f5a8	true	display.on.consent.screen
0bbbf6cd-0807-45e6-8814-dfe44200f5a8	${phoneScopeConsentText}	consent.screen.text
0bbbf6cd-0807-45e6-8814-dfe44200f5a8	true	include.in.token.scope
9ab24742-a022-47d1-ad7a-698eb22a2c90	true	display.on.consent.screen
9ab24742-a022-47d1-ad7a-698eb22a2c90	${rolesScopeConsentText}	consent.screen.text
9ab24742-a022-47d1-ad7a-698eb22a2c90	false	include.in.token.scope
b4efce83-2cee-432d-9b8c-eddddbce074a	false	display.on.consent.screen
b4efce83-2cee-432d-9b8c-eddddbce074a		consent.screen.text
b4efce83-2cee-432d-9b8c-eddddbce074a	false	include.in.token.scope
4ccf17fe-0bbb-4683-a121-19880aa8fd2d	false	display.on.consent.screen
4ccf17fe-0bbb-4683-a121-19880aa8fd2d	true	include.in.token.scope
ac211429-43b9-43aa-81d7-a6c886641fa8	false	display.on.consent.screen
ac211429-43b9-43aa-81d7-a6c886641fa8	false	include.in.token.scope
dc5cacff-c5cf-4fc2-8536-20b0fbbc1bee	false	display.on.consent.screen
dc5cacff-c5cf-4fc2-8536-20b0fbbc1bee	false	include.in.token.scope
41c99aee-bc3a-4911-92f6-19ea81a0b8c7	false	include.in.token.scope
41c99aee-bc3a-4911-92f6-19ea81a0b8c7	${rolesScopeConsentText}	consent.screen.text
41c99aee-bc3a-4911-92f6-19ea81a0b8c7	true	display.on.consent.screen
3b5722d1-34d4-4b0a-884a-e72be27bc0e1	false	include.in.token.scope
3b5722d1-34d4-4b0a-884a-e72be27bc0e1	false	display.on.consent.screen
04804ea5-24cd-4ecd-a5ba-3c04b571642a	${offlineAccessScopeConsentText}	consent.screen.text
04804ea5-24cd-4ecd-a5ba-3c04b571642a	true	display.on.consent.screen
7ebc8ff0-51f5-4db3-acec-94465d76eacc	true	include.in.token.scope
7ebc8ff0-51f5-4db3-acec-94465d76eacc	${phoneScopeConsentText}	consent.screen.text
7ebc8ff0-51f5-4db3-acec-94465d76eacc	true	display.on.consent.screen
bb65e029-32ef-4b42-b112-da44ded26610	true	include.in.token.scope
bb65e029-32ef-4b42-b112-da44ded26610	false	display.on.consent.screen
dbcd7999-b789-420c-b217-77f23844ac15	false	include.in.token.scope
dbcd7999-b789-420c-b217-77f23844ac15		consent.screen.text
dbcd7999-b789-420c-b217-77f23844ac15	false	display.on.consent.screen
5be4e042-446b-4ed0-9f16-d452e059de9d	false	include.in.token.scope
5be4e042-446b-4ed0-9f16-d452e059de9d	false	display.on.consent.screen
e7947f94-14db-454c-9696-7dad601e9a77	${samlRoleListScopeConsentText}	consent.screen.text
e7947f94-14db-454c-9696-7dad601e9a77	true	display.on.consent.screen
286d34ba-2b51-4c9c-af5b-86a057aece86	true	include.in.token.scope
286d34ba-2b51-4c9c-af5b-86a057aece86	${profileScopeConsentText}	consent.screen.text
286d34ba-2b51-4c9c-af5b-86a057aece86	true	display.on.consent.screen
24465872-0b69-4add-ae8f-1f99428eb6ba	true	include.in.token.scope
24465872-0b69-4add-ae8f-1f99428eb6ba	${emailScopeConsentText}	consent.screen.text
24465872-0b69-4add-ae8f-1f99428eb6ba	true	display.on.consent.screen
f9fb13b2-0b16-40a9-bf29-3996c78a1daa	true	include.in.token.scope
f9fb13b2-0b16-40a9-bf29-3996c78a1daa	${addressScopeConsentText}	consent.screen.text
f9fb13b2-0b16-40a9-bf29-3996c78a1daa	true	display.on.consent.screen
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
248766fb-d320-4a79-8a16-6567674baffd	dc5cacff-c5cf-4fc2-8536-20b0fbbc1bee	t
248766fb-d320-4a79-8a16-6567674baffd	9ab24742-a022-47d1-ad7a-698eb22a2c90	t
248766fb-d320-4a79-8a16-6567674baffd	f7ca2e9d-d959-41f6-8ab8-71703e1e09a6	t
248766fb-d320-4a79-8a16-6567674baffd	b4efce83-2cee-432d-9b8c-eddddbce074a	t
248766fb-d320-4a79-8a16-6567674baffd	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9	t
248766fb-d320-4a79-8a16-6567674baffd	ac211429-43b9-43aa-81d7-a6c886641fa8	t
248766fb-d320-4a79-8a16-6567674baffd	0bbbf6cd-0807-45e6-8814-dfe44200f5a8	f
248766fb-d320-4a79-8a16-6567674baffd	8e239cf6-2408-4c62-bcf8-0d10acb2a45b	f
248766fb-d320-4a79-8a16-6567674baffd	4ccf17fe-0bbb-4683-a121-19880aa8fd2d	f
248766fb-d320-4a79-8a16-6567674baffd	279f3670-aa45-40a8-ab87-e1e987c131b5	f
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	dc5cacff-c5cf-4fc2-8536-20b0fbbc1bee	t
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	9ab24742-a022-47d1-ad7a-698eb22a2c90	t
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	f7ca2e9d-d959-41f6-8ab8-71703e1e09a6	t
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	b4efce83-2cee-432d-9b8c-eddddbce074a	t
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9	t
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	ac211429-43b9-43aa-81d7-a6c886641fa8	t
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	0bbbf6cd-0807-45e6-8814-dfe44200f5a8	f
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	8e239cf6-2408-4c62-bcf8-0d10acb2a45b	f
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	4ccf17fe-0bbb-4683-a121-19880aa8fd2d	f
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	279f3670-aa45-40a8-ab87-e1e987c131b5	f
f7d3b0c2-4247-45b7-b45d-ba96cf20c450	dc5cacff-c5cf-4fc2-8536-20b0fbbc1bee	t
f7d3b0c2-4247-45b7-b45d-ba96cf20c450	9ab24742-a022-47d1-ad7a-698eb22a2c90	t
f7d3b0c2-4247-45b7-b45d-ba96cf20c450	f7ca2e9d-d959-41f6-8ab8-71703e1e09a6	t
f7d3b0c2-4247-45b7-b45d-ba96cf20c450	b4efce83-2cee-432d-9b8c-eddddbce074a	t
f7d3b0c2-4247-45b7-b45d-ba96cf20c450	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9	t
f7d3b0c2-4247-45b7-b45d-ba96cf20c450	ac211429-43b9-43aa-81d7-a6c886641fa8	t
f7d3b0c2-4247-45b7-b45d-ba96cf20c450	0bbbf6cd-0807-45e6-8814-dfe44200f5a8	f
f7d3b0c2-4247-45b7-b45d-ba96cf20c450	8e239cf6-2408-4c62-bcf8-0d10acb2a45b	f
f7d3b0c2-4247-45b7-b45d-ba96cf20c450	4ccf17fe-0bbb-4683-a121-19880aa8fd2d	f
f7d3b0c2-4247-45b7-b45d-ba96cf20c450	279f3670-aa45-40a8-ab87-e1e987c131b5	f
a6d97eed-774b-46cd-9d6b-05f70534bb6d	dc5cacff-c5cf-4fc2-8536-20b0fbbc1bee	t
a6d97eed-774b-46cd-9d6b-05f70534bb6d	9ab24742-a022-47d1-ad7a-698eb22a2c90	t
a6d97eed-774b-46cd-9d6b-05f70534bb6d	f7ca2e9d-d959-41f6-8ab8-71703e1e09a6	t
a6d97eed-774b-46cd-9d6b-05f70534bb6d	b4efce83-2cee-432d-9b8c-eddddbce074a	t
a6d97eed-774b-46cd-9d6b-05f70534bb6d	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9	t
a6d97eed-774b-46cd-9d6b-05f70534bb6d	ac211429-43b9-43aa-81d7-a6c886641fa8	t
a6d97eed-774b-46cd-9d6b-05f70534bb6d	0bbbf6cd-0807-45e6-8814-dfe44200f5a8	f
a6d97eed-774b-46cd-9d6b-05f70534bb6d	8e239cf6-2408-4c62-bcf8-0d10acb2a45b	f
a6d97eed-774b-46cd-9d6b-05f70534bb6d	4ccf17fe-0bbb-4683-a121-19880aa8fd2d	f
a6d97eed-774b-46cd-9d6b-05f70534bb6d	279f3670-aa45-40a8-ab87-e1e987c131b5	f
433248d8-6ac7-475a-a9cd-6a7977a2c034	dc5cacff-c5cf-4fc2-8536-20b0fbbc1bee	t
433248d8-6ac7-475a-a9cd-6a7977a2c034	9ab24742-a022-47d1-ad7a-698eb22a2c90	t
433248d8-6ac7-475a-a9cd-6a7977a2c034	f7ca2e9d-d959-41f6-8ab8-71703e1e09a6	t
433248d8-6ac7-475a-a9cd-6a7977a2c034	b4efce83-2cee-432d-9b8c-eddddbce074a	t
433248d8-6ac7-475a-a9cd-6a7977a2c034	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9	t
433248d8-6ac7-475a-a9cd-6a7977a2c034	ac211429-43b9-43aa-81d7-a6c886641fa8	t
433248d8-6ac7-475a-a9cd-6a7977a2c034	0bbbf6cd-0807-45e6-8814-dfe44200f5a8	f
433248d8-6ac7-475a-a9cd-6a7977a2c034	8e239cf6-2408-4c62-bcf8-0d10acb2a45b	f
433248d8-6ac7-475a-a9cd-6a7977a2c034	4ccf17fe-0bbb-4683-a121-19880aa8fd2d	f
433248d8-6ac7-475a-a9cd-6a7977a2c034	279f3670-aa45-40a8-ab87-e1e987c131b5	f
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	dc5cacff-c5cf-4fc2-8536-20b0fbbc1bee	t
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	9ab24742-a022-47d1-ad7a-698eb22a2c90	t
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	f7ca2e9d-d959-41f6-8ab8-71703e1e09a6	t
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	b4efce83-2cee-432d-9b8c-eddddbce074a	t
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9	t
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	ac211429-43b9-43aa-81d7-a6c886641fa8	t
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	0bbbf6cd-0807-45e6-8814-dfe44200f5a8	f
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	8e239cf6-2408-4c62-bcf8-0d10acb2a45b	f
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	4ccf17fe-0bbb-4683-a121-19880aa8fd2d	f
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	279f3670-aa45-40a8-ab87-e1e987c131b5	f
91089183-fce3-4047-a65d-ee0d02228343	dbcd7999-b789-420c-b217-77f23844ac15	t
91089183-fce3-4047-a65d-ee0d02228343	5be4e042-446b-4ed0-9f16-d452e059de9d	t
91089183-fce3-4047-a65d-ee0d02228343	41c99aee-bc3a-4911-92f6-19ea81a0b8c7	t
91089183-fce3-4047-a65d-ee0d02228343	286d34ba-2b51-4c9c-af5b-86a057aece86	t
91089183-fce3-4047-a65d-ee0d02228343	3b5722d1-34d4-4b0a-884a-e72be27bc0e1	t
91089183-fce3-4047-a65d-ee0d02228343	24465872-0b69-4add-ae8f-1f99428eb6ba	t
91089183-fce3-4047-a65d-ee0d02228343	f9fb13b2-0b16-40a9-bf29-3996c78a1daa	f
91089183-fce3-4047-a65d-ee0d02228343	7ebc8ff0-51f5-4db3-acec-94465d76eacc	f
91089183-fce3-4047-a65d-ee0d02228343	04804ea5-24cd-4ecd-a5ba-3c04b571642a	f
91089183-fce3-4047-a65d-ee0d02228343	bb65e029-32ef-4b42-b112-da44ded26610	f
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	dbcd7999-b789-420c-b217-77f23844ac15	t
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	5be4e042-446b-4ed0-9f16-d452e059de9d	t
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	41c99aee-bc3a-4911-92f6-19ea81a0b8c7	t
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	286d34ba-2b51-4c9c-af5b-86a057aece86	t
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	3b5722d1-34d4-4b0a-884a-e72be27bc0e1	t
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	24465872-0b69-4add-ae8f-1f99428eb6ba	t
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	f9fb13b2-0b16-40a9-bf29-3996c78a1daa	f
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	7ebc8ff0-51f5-4db3-acec-94465d76eacc	f
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	04804ea5-24cd-4ecd-a5ba-3c04b571642a	f
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	bb65e029-32ef-4b42-b112-da44ded26610	f
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	dbcd7999-b789-420c-b217-77f23844ac15	t
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	5be4e042-446b-4ed0-9f16-d452e059de9d	t
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	41c99aee-bc3a-4911-92f6-19ea81a0b8c7	t
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	286d34ba-2b51-4c9c-af5b-86a057aece86	t
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	3b5722d1-34d4-4b0a-884a-e72be27bc0e1	t
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	24465872-0b69-4add-ae8f-1f99428eb6ba	t
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	f9fb13b2-0b16-40a9-bf29-3996c78a1daa	f
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	7ebc8ff0-51f5-4db3-acec-94465d76eacc	f
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	04804ea5-24cd-4ecd-a5ba-3c04b571642a	f
6368b30f-a0a7-4c96-bd53-7cea84ed0efe	bb65e029-32ef-4b42-b112-da44ded26610	f
5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	dbcd7999-b789-420c-b217-77f23844ac15	t
5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	5be4e042-446b-4ed0-9f16-d452e059de9d	t
5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	41c99aee-bc3a-4911-92f6-19ea81a0b8c7	t
5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	286d34ba-2b51-4c9c-af5b-86a057aece86	t
5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	24465872-0b69-4add-ae8f-1f99428eb6ba	t
5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	f9fb13b2-0b16-40a9-bf29-3996c78a1daa	f
5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	7ebc8ff0-51f5-4db3-acec-94465d76eacc	f
5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	04804ea5-24cd-4ecd-a5ba-3c04b571642a	f
5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	bb65e029-32ef-4b42-b112-da44ded26610	f
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	dbcd7999-b789-420c-b217-77f23844ac15	t
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	5be4e042-446b-4ed0-9f16-d452e059de9d	t
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	41c99aee-bc3a-4911-92f6-19ea81a0b8c7	t
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	286d34ba-2b51-4c9c-af5b-86a057aece86	t
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	3b5722d1-34d4-4b0a-884a-e72be27bc0e1	t
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	24465872-0b69-4add-ae8f-1f99428eb6ba	t
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	f9fb13b2-0b16-40a9-bf29-3996c78a1daa	f
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	7ebc8ff0-51f5-4db3-acec-94465d76eacc	f
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	04804ea5-24cd-4ecd-a5ba-3c04b571642a	f
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	bb65e029-32ef-4b42-b112-da44ded26610	f
810f8ebf-9023-4c80-a734-65b7ee07eb63	dbcd7999-b789-420c-b217-77f23844ac15	t
810f8ebf-9023-4c80-a734-65b7ee07eb63	5be4e042-446b-4ed0-9f16-d452e059de9d	t
810f8ebf-9023-4c80-a734-65b7ee07eb63	41c99aee-bc3a-4911-92f6-19ea81a0b8c7	t
810f8ebf-9023-4c80-a734-65b7ee07eb63	286d34ba-2b51-4c9c-af5b-86a057aece86	t
810f8ebf-9023-4c80-a734-65b7ee07eb63	24465872-0b69-4add-ae8f-1f99428eb6ba	t
810f8ebf-9023-4c80-a734-65b7ee07eb63	f9fb13b2-0b16-40a9-bf29-3996c78a1daa	f
810f8ebf-9023-4c80-a734-65b7ee07eb63	7ebc8ff0-51f5-4db3-acec-94465d76eacc	f
810f8ebf-9023-4c80-a734-65b7ee07eb63	04804ea5-24cd-4ecd-a5ba-3c04b571642a	f
810f8ebf-9023-4c80-a734-65b7ee07eb63	bb65e029-32ef-4b42-b112-da44ded26610	f
61ae9827-8300-4046-a78b-6fc1df466f66	dbcd7999-b789-420c-b217-77f23844ac15	t
61ae9827-8300-4046-a78b-6fc1df466f66	5be4e042-446b-4ed0-9f16-d452e059de9d	t
61ae9827-8300-4046-a78b-6fc1df466f66	41c99aee-bc3a-4911-92f6-19ea81a0b8c7	t
61ae9827-8300-4046-a78b-6fc1df466f66	286d34ba-2b51-4c9c-af5b-86a057aece86	t
61ae9827-8300-4046-a78b-6fc1df466f66	3b5722d1-34d4-4b0a-884a-e72be27bc0e1	t
61ae9827-8300-4046-a78b-6fc1df466f66	24465872-0b69-4add-ae8f-1f99428eb6ba	t
61ae9827-8300-4046-a78b-6fc1df466f66	f9fb13b2-0b16-40a9-bf29-3996c78a1daa	f
61ae9827-8300-4046-a78b-6fc1df466f66	7ebc8ff0-51f5-4db3-acec-94465d76eacc	f
61ae9827-8300-4046-a78b-6fc1df466f66	04804ea5-24cd-4ecd-a5ba-3c04b571642a	f
61ae9827-8300-4046-a78b-6fc1df466f66	bb65e029-32ef-4b42-b112-da44ded26610	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
8e239cf6-2408-4c62-bcf8-0d10acb2a45b	406c581b-849c-4c90-b58e-c810c5c6127b
04804ea5-24cd-4ecd-a5ba-3c04b571642a	e2795302-0ee8-45e4-91c8-400246ef9b5b
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
bceb9b7b-dcd9-4f11-9aeb-129be6148484	Trusted Hosts	1188f655-9676-4630-ba0e-451e8cbc5697	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1188f655-9676-4630-ba0e-451e8cbc5697	anonymous
349ae8cd-b9d5-4835-8cd0-5ffc0a62e0bf	Consent Required	1188f655-9676-4630-ba0e-451e8cbc5697	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1188f655-9676-4630-ba0e-451e8cbc5697	anonymous
bf2d0d0e-686a-45d1-a5c7-fd95cd65b7df	Full Scope Disabled	1188f655-9676-4630-ba0e-451e8cbc5697	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1188f655-9676-4630-ba0e-451e8cbc5697	anonymous
e9714947-fffb-442f-8f51-1744f7c156f4	Max Clients Limit	1188f655-9676-4630-ba0e-451e8cbc5697	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1188f655-9676-4630-ba0e-451e8cbc5697	anonymous
024fec04-8d83-476a-af42-6e3ce79f3788	Allowed Protocol Mapper Types	1188f655-9676-4630-ba0e-451e8cbc5697	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1188f655-9676-4630-ba0e-451e8cbc5697	anonymous
b9e12fa2-2cbe-424b-8996-726a2566cc8f	Allowed Client Scopes	1188f655-9676-4630-ba0e-451e8cbc5697	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1188f655-9676-4630-ba0e-451e8cbc5697	anonymous
f838649b-d27f-42a9-b8d2-e448090061dc	Allowed Protocol Mapper Types	1188f655-9676-4630-ba0e-451e8cbc5697	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1188f655-9676-4630-ba0e-451e8cbc5697	authenticated
d5e8ca58-f280-49ca-b658-4cfac668b5bb	Allowed Client Scopes	1188f655-9676-4630-ba0e-451e8cbc5697	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1188f655-9676-4630-ba0e-451e8cbc5697	authenticated
bf140716-f59c-4219-8e92-11790d8d550f	rsa-generated	1188f655-9676-4630-ba0e-451e8cbc5697	rsa-generated	org.keycloak.keys.KeyProvider	1188f655-9676-4630-ba0e-451e8cbc5697	\N
ffe25f6f-c7d6-4af9-bde9-b31ff8d1c61d	rsa-enc-generated	1188f655-9676-4630-ba0e-451e8cbc5697	rsa-enc-generated	org.keycloak.keys.KeyProvider	1188f655-9676-4630-ba0e-451e8cbc5697	\N
10f00947-5f8e-4e5c-95d0-da2249605841	hmac-generated-hs512	1188f655-9676-4630-ba0e-451e8cbc5697	hmac-generated	org.keycloak.keys.KeyProvider	1188f655-9676-4630-ba0e-451e8cbc5697	\N
d6bb5b3c-4153-41ec-8340-c0ad62067554	aes-generated	1188f655-9676-4630-ba0e-451e8cbc5697	aes-generated	org.keycloak.keys.KeyProvider	1188f655-9676-4630-ba0e-451e8cbc5697	\N
572f4f34-3664-4513-a3de-f64559cd3ed3	\N	1188f655-9676-4630-ba0e-451e8cbc5697	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	1188f655-9676-4630-ba0e-451e8cbc5697	\N
feaab5d7-1377-40a5-a232-3a0fa11af285	Full Scope Disabled	0ff635a9-4a9c-47af-8eec-860d88e871e8	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ff635a9-4a9c-47af-8eec-860d88e871e8	anonymous
af4da707-aa33-4cef-8a99-283006c27ad7	Consent Required	0ff635a9-4a9c-47af-8eec-860d88e871e8	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ff635a9-4a9c-47af-8eec-860d88e871e8	anonymous
908949c4-5f02-423d-9078-27a09befbf89	Allowed Client Scopes	0ff635a9-4a9c-47af-8eec-860d88e871e8	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ff635a9-4a9c-47af-8eec-860d88e871e8	authenticated
56bf0d74-4422-420c-942d-5f3158d6a1e7	Allowed Protocol Mapper Types	0ff635a9-4a9c-47af-8eec-860d88e871e8	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ff635a9-4a9c-47af-8eec-860d88e871e8	anonymous
bd8e2397-aaa9-4b87-94a2-1c2867e46dee	Allowed Client Scopes	0ff635a9-4a9c-47af-8eec-860d88e871e8	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ff635a9-4a9c-47af-8eec-860d88e871e8	anonymous
1ad04d83-5569-4e7c-a9d2-de0880b77e76	Allowed Protocol Mapper Types	0ff635a9-4a9c-47af-8eec-860d88e871e8	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ff635a9-4a9c-47af-8eec-860d88e871e8	authenticated
9bcc891b-1355-4552-a3f0-61fe304b8b72	Trusted Hosts	0ff635a9-4a9c-47af-8eec-860d88e871e8	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ff635a9-4a9c-47af-8eec-860d88e871e8	anonymous
bf1c202c-8dd4-4522-87f4-5f03b6db2038	Max Clients Limit	0ff635a9-4a9c-47af-8eec-860d88e871e8	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ff635a9-4a9c-47af-8eec-860d88e871e8	anonymous
693693c4-7056-4c5f-83df-fa8ff6d77a56	\N	0ff635a9-4a9c-47af-8eec-860d88e871e8	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	0ff635a9-4a9c-47af-8eec-860d88e871e8	\N
4e86a127-399a-4af6-a57d-49a308e9a3a1	rsa-generated	0ff635a9-4a9c-47af-8eec-860d88e871e8	rsa-generated	org.keycloak.keys.KeyProvider	0ff635a9-4a9c-47af-8eec-860d88e871e8	\N
5f6463f4-6876-4363-95c3-a20a419ce3d5	hmac-generated-hs512	0ff635a9-4a9c-47af-8eec-860d88e871e8	hmac-generated	org.keycloak.keys.KeyProvider	0ff635a9-4a9c-47af-8eec-860d88e871e8	\N
c2e1c3a3-05dd-47d1-a7d1-f520cd721040	hmac-generated	0ff635a9-4a9c-47af-8eec-860d88e871e8	hmac-generated	org.keycloak.keys.KeyProvider	0ff635a9-4a9c-47af-8eec-860d88e871e8	\N
92509665-4e6a-4fac-b6b1-f69ff763cabf	rsa-enc-generated	0ff635a9-4a9c-47af-8eec-860d88e871e8	rsa-enc-generated	org.keycloak.keys.KeyProvider	0ff635a9-4a9c-47af-8eec-860d88e871e8	\N
8195bd04-09e8-4c69-99a2-5db938660664	aes-generated	0ff635a9-4a9c-47af-8eec-860d88e871e8	aes-generated	org.keycloak.keys.KeyProvider	0ff635a9-4a9c-47af-8eec-860d88e871e8	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
30f7f2c0-e2bd-4039-8b53-c875fa632e38	b9e12fa2-2cbe-424b-8996-726a2566cc8f	allow-default-scopes	true
bb0fc559-3ff3-4eed-9d7b-62314b81d720	d5e8ca58-f280-49ca-b658-4cfac668b5bb	allow-default-scopes	true
82fa1814-cb36-4337-b776-43d929203c2c	bceb9b7b-dcd9-4f11-9aeb-129be6148484	client-uris-must-match	true
6b02f02e-a464-4f58-af57-f5c27b93b88d	bceb9b7b-dcd9-4f11-9aeb-129be6148484	host-sending-registration-request-must-match	true
1dae7de1-0372-4725-bc64-edb2da26a3c9	024fec04-8d83-476a-af42-6e3ce79f3788	allowed-protocol-mapper-types	saml-user-attribute-mapper
1e5c4871-67f2-4677-9b9c-3cc054bad4ed	024fec04-8d83-476a-af42-6e3ce79f3788	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
856066d4-9c49-4cb7-9265-e9fc5f1fb6ef	024fec04-8d83-476a-af42-6e3ce79f3788	allowed-protocol-mapper-types	saml-user-property-mapper
b6303fe0-3151-4988-9fdf-bb674b3b3f0e	024fec04-8d83-476a-af42-6e3ce79f3788	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
55e67c35-cb01-4507-9957-388277c5af5c	024fec04-8d83-476a-af42-6e3ce79f3788	allowed-protocol-mapper-types	oidc-full-name-mapper
b6223bb9-7a55-48ed-8798-690aa806b5de	024fec04-8d83-476a-af42-6e3ce79f3788	allowed-protocol-mapper-types	saml-role-list-mapper
f182ceeb-e873-48e4-8156-4f3c552f6ec5	024fec04-8d83-476a-af42-6e3ce79f3788	allowed-protocol-mapper-types	oidc-address-mapper
baa8ff89-e913-468d-95f0-120a00439d79	024fec04-8d83-476a-af42-6e3ce79f3788	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
8c741491-473c-486f-b24f-13154d5fe2a8	e9714947-fffb-442f-8f51-1744f7c156f4	max-clients	200
403b7fa6-2820-40ef-bea5-fb80f422de73	f838649b-d27f-42a9-b8d2-e448090061dc	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3b6af032-fd89-4db8-8407-150ef121577d	f838649b-d27f-42a9-b8d2-e448090061dc	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0e9cc745-1c44-4d6d-9593-d8dc505d0603	f838649b-d27f-42a9-b8d2-e448090061dc	allowed-protocol-mapper-types	saml-user-attribute-mapper
390932cc-a410-4b78-b44f-eb02cc2fdf60	f838649b-d27f-42a9-b8d2-e448090061dc	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ec97d2b7-6b1c-4cb9-9507-1202dcf50b92	f838649b-d27f-42a9-b8d2-e448090061dc	allowed-protocol-mapper-types	saml-user-property-mapper
5df8dffd-1887-4f92-b818-bea0bb82564a	f838649b-d27f-42a9-b8d2-e448090061dc	allowed-protocol-mapper-types	oidc-address-mapper
8e867ac2-8d0b-46d3-bc45-ab96b25683da	f838649b-d27f-42a9-b8d2-e448090061dc	allowed-protocol-mapper-types	saml-role-list-mapper
32283a12-5208-4005-8159-674ee69435db	f838649b-d27f-42a9-b8d2-e448090061dc	allowed-protocol-mapper-types	oidc-full-name-mapper
146eaf5a-2151-4c5c-8632-04cfb7d95711	572f4f34-3664-4513-a3de-f64559cd3ed3	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
8ffbcd41-7ab1-4d2f-b7e0-b7f1c2b79473	ffe25f6f-c7d6-4af9-bde9-b31ff8d1c61d	certificate	MIICmzCCAYMCBgGS//Y5KjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQxMTA2MDUzMTE5WhcNMzQxMTA2MDUzMjU5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC6/yBgRZiOtBPw9yMf+E0KxRwFT9TB/LHA0Pd0tIiVgXQotk+/ASgIdhK6/rJT1k91KNDgt9BfAN2H7e0EgN6bljqZI0K4P1LHO5CJU0bkhqFqsvAtQ1BI0bLFkYfSG0ASjIaoFsOVRBk0SnAKSP6c94MABX9QCrhWkorS3wTe7tzz3/pH/ta9xYfg0BnmuNmVRMKpUvbtvV472Lh85Ed8fz/loP6IYrfAA1DCdmZ+0xFgJi/eyoYp6AUjuq7vzjtV785eiiIe1xaymCHiu0lX112eKK7TLzhi3gs1o9TqSF0MqEF5VoiSh6JpycKRTiN0aCtaRAdFDwo/bu4NE/0ZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBALO+QcqOldwTnrbcSp92CdEpuCF+tE2lc6lIorcOL600q4QuOXLBuo1Qm1NsKmpTqTRlwt/HLbSfNVpXFKcEERgZ3wDnwHYT36AMpquIbWFfMYBVeKLzjP6ykDA4yZ9VCJNDFFZVEdcwzm6S8GTcqUr4VqC7MP2Ae4ZfZTt4g5TCcaVv/X8LQSiO9PMzN35B/nS0Y8UmKhfOAI2zHp4oqkSP7ALfiQSgD2i8Y1gvzhRR+F9syT97C4uWr+407CwAU2Xj+5i/MuhhSKmLlTCrdZqel01aWKZWq74uAunYpBighn0cha46vBml+SL/alZpXA8HwB0whLNKCUZAC5ZjwG8=
27f450cf-27c7-453e-bac0-da5d76acb79e	ffe25f6f-c7d6-4af9-bde9-b31ff8d1c61d	priority	100
68760952-682d-4feb-8a11-134cd5d15623	ffe25f6f-c7d6-4af9-bde9-b31ff8d1c61d	privateKey	MIIEowIBAAKCAQEAuv8gYEWYjrQT8PcjH/hNCsUcBU/UwfyxwND3dLSIlYF0KLZPvwEoCHYSuv6yU9ZPdSjQ4LfQXwDdh+3tBIDem5Y6mSNCuD9SxzuQiVNG5IaharLwLUNQSNGyxZGH0htAEoyGqBbDlUQZNEpwCkj+nPeDAAV/UAq4VpKK0t8E3u7c89/6R/7WvcWH4NAZ5rjZlUTCqVL27b1eO9i4fORHfH8/5aD+iGK3wANQwnZmftMRYCYv3sqGKegFI7qu7847Ve/OXooiHtcWspgh4rtJV9ddniiu0y84Yt4LNaPU6khdDKhBeVaIkoeiacnCkU4jdGgrWkQHRQ8KP27uDRP9GQIDAQABAoIBAALWfNoL1wHGvgJl6cCiNB8coy0kdezfZh4wPap7KT3QRLWadgbcIGH9KBHHlugP+aLkSe6NyOnW2ZsmvfZXyKkRTwCEc7ktQtcXB72XHTK6JVMjyzfQofRc9FWBvM8wOS50N1Xv3yt8ff/DEm9hhgsBSZm+O51OGwKQqkPYJ8WEppsYR+wdApiph1yxjxkO6EmXW4S1RNRivhQ6PKiQ507+qcDkzUX+t4KAk19u0ML1Y291XU4YnMqZy7hUNOMxPcSXRezO/XjajrxCV2mKE/gFO8LHW0YrUa8TPRPO2vtlA3roX2VkGn6Cl2ppnN3UYM/1KscBK+Od9XUztV99+0UCgYEA/c9NqiPEseSv4TB/oE+J53PM2NSWAiKrObbmWbYJlmkyLF3to8qWpfTsUHA32y0VLhv9FkUU7eqaq4pnztG1RkFd5kKKHSnFcZbehaC4eEuajaF46bkSons7BqMDxncuCrIrZt7O8GvEwudMcVJBp0sp2FItAZ4UdRZ/ggyevj0CgYEAvJw5gfP7q//7tmAdDL86cIh5fnAWXptZPEWL5G/A1ZvQJ50XzWt/c1qLLrxe9/9xufN0YmOHFAU8wFTas9QxNJ022XA2FfFOwM3M9OWAcb5jWWO4qGrYWXzAmbMChVgkU/YDXxgCbCETldRgX95FGL3v0q0oOwI+JpxP8mVO5A0CgYEAtKBDdUHfSXqmcGxDZ6MzUTRoJCemWf6yPHCdnlqemBxlSI3QATC75X9YbiZumdyLpjTk+GRRcL/1Mv9cwSMdDtKWMLhJ8lc33I6x7gdjQLkNVJ4Fns/HIzrv1tlMZoGKkrIZkSwfuZn4fXx+Omd/sb8cGIbi4LPPe0R3meXBU0ECgYAaj3F1wHMHhLPgueY9XkyPfliFmqk7x2qoly6dC7O/IQMOIQwyDFpVV0HUYgiJqfpM8mDIXjWudxJYD1sBCfen7h/EPQ4QxvuNIS4kqpEM83+wHd/qL6mp6GyC+Hd5abEr9bAB2zK0IXBNoCu2NGnMkyrLo0DQFn/EFi0X+HZEnQKBgFxei/BJIJ9CEpodI7W0Jk0qaHPfkL5l4dy/TtesKSh+kuhqH0o33I0xsOqjIY9AlXxakCdxzyFIGwjnGDm5QFK6GzPAPUh7Wzti+UJvGx0zgKlYTmYu/y91tM/dZFAXVXQGmxsl2i7/fuDTht3Ek0KHqd0u1r2vmC1JwgitTQaX
8ed91b38-5229-411e-8d84-613bd6d3476e	ffe25f6f-c7d6-4af9-bde9-b31ff8d1c61d	keyUse	ENC
a46a66a2-3679-4c7f-bd8d-277eb9d78eb3	ffe25f6f-c7d6-4af9-bde9-b31ff8d1c61d	algorithm	RSA-OAEP
ab7723aa-8c42-489d-a928-6c060bc74b2f	10f00947-5f8e-4e5c-95d0-da2249605841	priority	100
b727b1b2-3be2-49c2-8957-a877944af3fe	10f00947-5f8e-4e5c-95d0-da2249605841	kid	8050fb8a-1d67-444b-8517-54f9ad2a65b3
a191e724-73f8-4da1-ba2a-4e6dfe26e3ce	10f00947-5f8e-4e5c-95d0-da2249605841	algorithm	HS512
26424ed9-389b-4c56-bbad-5dd24b6f6276	10f00947-5f8e-4e5c-95d0-da2249605841	secret	TuKYUw94c6zXEs0FxQ-jGxON9I3yimlv6zKAx6nrgk96Yu_QZFmUZoTCoAP-wdJDbdw2LiI23mRrIMt-gpb0Mc89LxdUxIjDVdtpRe6Vzbhkvj6DhhEFbiCSHxCDskLt6Bon9iymQpQsrsoCV7xrONdOYKWEoTZW9Kvelzc-mhI
73774dde-4c78-441f-bf7b-b895ab32d2fd	d6bb5b3c-4153-41ec-8340-c0ad62067554	secret	96SP8sKL9Ob671XnceyezA
811cf1b7-f1bc-4b38-843c-0a03e0f5ee6f	d6bb5b3c-4153-41ec-8340-c0ad62067554	priority	100
77e93097-a5d3-4c17-a12d-c53325bfc651	d6bb5b3c-4153-41ec-8340-c0ad62067554	kid	9c549734-04ad-4792-b041-2ea942164586
a2534aa3-dd67-457d-946e-e75c7736e5ce	bf140716-f59c-4219-8e92-11790d8d550f	certificate	MIICmzCCAYMCBgGS//Y35DANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQxMTA2MDUzMTE5WhcNMzQxMTA2MDUzMjU5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCZH2hU01dgOhg7wuH1ocfDZeIxfcKO7xUvR/+UrpB9DEf7oHXS4GJCuPegKtM2vIQM+OENbkih8MELoW/dp7vaa79nmvvrmvMaDHjRDPq65qT4oYcv4D3cPutoW3sg1ALT85Xdn1lCBSXTZZhppxjdAE1R93FWVbiE9VbG+Dx+4mIGUfq/V2ypfQ+UfSZ68/4ODZKxhgMGaT147vRzT+LWLSX1ktFR/Jyvo3DW3U+KSonbzYU5mls1NP4u7/GQkMUoS0XDpHehu1A2etyArw5KkMyfYv8tgKiDQ3CNOFDE0VzCp8YbCBAzWMUgWcL5AceuSgNC0njisQpg7socE1QVAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACBwg2ltBU4LbT3Qm1tvUxTACmdDGgWpgSzq2CupmG92Sm/PyyIknTYhToUGgaODDWS+BhzJ+ENtuqXW08yg1HQgPFdNb4omWeHTjXeM+V763AbK51QPoaVsqiAt7UnI1YTLh4XGrD/spkAAwvcXIexP4XPR3oWj0pS/WVBTPeVxce0cd24mSlCfHmvT4qM9NAKaZrNjb5ObikHcLq4qbDfMKrv6zXjzThsQ73GOXeiZ2JBONC0Z+ObIOm+uQWeX802dRCB19lG3J5DCmt9NpPHe+XeaTC9k6tpor+O+qAc+fd8OSfdDfoNFfVurgG4cgZTX311aiSc0nMi9KYyXlOU=
f213e35b-3639-4ac4-9676-79559fb9c36c	bf140716-f59c-4219-8e92-11790d8d550f	keyUse	SIG
847c8a9f-3d00-4fb8-8c94-b7f28c9fd462	bf140716-f59c-4219-8e92-11790d8d550f	priority	100
ed7c35b4-b649-4c76-b8b8-233573d0d703	bf140716-f59c-4219-8e92-11790d8d550f	privateKey	MIIEowIBAAKCAQEAmR9oVNNXYDoYO8Lh9aHHw2XiMX3Cju8VL0f/lK6QfQxH+6B10uBiQrj3oCrTNryEDPjhDW5IofDBC6Fv3ae72mu/Z5r765rzGgx40Qz6uuak+KGHL+A93D7raFt7INQC0/OV3Z9ZQgUl02WYaacY3QBNUfdxVlW4hPVWxvg8fuJiBlH6v1dsqX0PlH0mevP+Dg2SsYYDBmk9eO70c0/i1i0l9ZLRUfycr6Nw1t1PikqJ282FOZpbNTT+Lu/xkJDFKEtFw6R3obtQNnrcgK8OSpDMn2L/LYCog0NwjThQxNFcwqfGGwgQM1jFIFnC+QHHrkoDQtJ44rEKYO7KHBNUFQIDAQABAoIBAATkr5qBKLC3zChbjXAicL/IqZTJnAMIcDdTJPKgRuUXVFT3fZ4IH/bzZWBxaRxw8LeSzx7B6G4A0F6AVN+ZWZcjLECRzJ0TItOXur2tg6hSfUrZXwVZ56HHKSufO5a8biNOJiFcUzq/oncriKMc6d4k9HoBcklr+SojxmRN49SgxHcpPh/cYvNrDWxO9Db6vS9iLvq0SDr/HEFFsXzcyyWNZShnIfUihMRZkiVrGKyoMh8zu3J/U0OMv7oR/Mm2zyFpd8cjl7J7dHxwfAVTGB+Et2HpRxDarW/uMwwE1milqI+i7YuGJ6GXt2jtLEArTl59nlGSjl2BH0bKNJFhdykCgYEAynZrcJ3jKDkDhs2j8l+NjpdskbsYdLK3w+O9mZvf3um10UzJB25v6ejuvGCCjUmYWWq3xhSI5gGZcNxkSul65ERy/DgCGr9Nb87FJIbXCTHlWpUrASPutELM0CvN7KU3FQDnjsVcItNEjr6/MM24452FGUQfKVJh0qPB45E03E0CgYEAwZz0P/V5IXxvVb++TZ6FCnoyJHRjaAWB9NhlpSo9rBr+0C7Ju3tDRbq0Oow9ylHZXI/uGztkM9cX8imv6qztuCJ+9D5t0Pd70joI5CsdRxtqRsi/yNNAFUQhzJJlgSZSynyAL7Nv4RwGkiMFtJdO0IVO6iep/GHnrQuMNhZzGukCgYAwHNAPZRXUOyhBYqDxOg/TsNxWDVYUdVwCKx6lYEtlF7jjUhH7uBzUQ0xoa67akICpzxh48+xMbFjgXx9eRfm0QSfqFA07+fYW+dYThg+X2cmdKxGbJcTWBYHSfnZjJCfgz+Q3I2NvyzDhkyawHFMxk/9LL8sP8MnaWpv6zkj3iQKBgDSBiSezPXdcVKEvj79jBvdxbhm+ypqSK80nxmEFVJZQ99ujZKgIZJULbgcWs0cj7UuR6OPPtnvskBznO0LsRMeT61P3fjaWdyjq/jBKlPUMtUSe+ovO5mkeAgCFjyt4Jimtm+HTyrqErC+Dee+gvQoFrQIJYasFLhwarpqYefzJAoGBAIqyEnX8YislLlPB8iHW8a4n2OvdTYcbYG2tjj9Zh74Trs8EYJWTypeNYnlzvKGn69hFp/Au1Tg1TM1jeq0nKdpsOPsX+6fFogZ1Hf69UhFVTZW0mCw/5mw6Vc3SPxi0F4zDTZRG6vlbdQEi4QeTRF5ThfAsbc4UQXpNjvJdLGXd
b9677d55-fc43-4eda-b6f4-f88228c5a651	4e86a127-399a-4af6-a57d-49a308e9a3a1	certificate	MIICrzCCAZcCBgGS//Zx/TANBgkqhkiG9w0BAQsFADAbMRkwFwYDVQQDDBBUZXN0Q29tcGFueVJlYWxtMB4XDTI0MTEwNjA1MzEzNFoXDTM0MTEwNjA1MzMxNFowGzEZMBcGA1UEAwwQVGVzdENvbXBhbnlSZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALLOezWn6izuppgYOkVZ8gMQ7fT4JpdN2D1bSuaFS5n8wGmncL3tANyCgJzxPeMb9Tu/mWQzJ2YPgDN5F0UQXUOXP94KkB2DATbl4O02UGA1zylfDPQYnj2/Rk67Z67LciG/TWp3mzOFePpGHbcOiDU4fDzGRfIkghzncVDOqqQyzf+VashZ+uJuAPMJU8hnK9HJ9ORZgVBJr6qFLcp98eEPz9onM1egAbSQbTNGm0s47hPR1vhB49utAAWLXhDPzPHzobAexviWH8W5khvyAUZ67ECtxqMUFwTqEw+xfAvQ2DOgFeXQRM3LkquKHEJ/aX9unCHN9i+H/jqXP5YVdXMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAA2MNUjyZCJXTzMLx8nXotyEFX2D1ATQEOQqiPDaY6ghXSrudh2w3/yA7ErWmbRohCbPZZe0BbiK/g4im0RegKrMpg6urut4mNH0WgmWGw2JE2douIZq4Fmidea47Nc0jvOjSbIMMvdAPaCCEOQ87RBqDNENLcAh2jzZSCdpVkDTYZxAAdaDD/LyY7+SGnjm6isqXV0ZOVrvG6puWsRwU9x3QrcnlmR2xjTDX6fnkViCIXsFxVPWgFYy8bEEeNAk2v/Sz9tkDD9+lP0MxsDNugD+apBzY+O9oiFlNBryfE7GKew+GXCe22esDJ85oPHcGKUvVN7ovi+5qeyqOEoBDYw==
23901c90-a86d-4afa-b3fb-4dfb61136487	4e86a127-399a-4af6-a57d-49a308e9a3a1	privateKey	MIIEpAIBAAKCAQEAss57NafqLO6mmBg6RVnyAxDt9Pgml03YPVtK5oVLmfzAaadwve0A3IKAnPE94xv1O7+ZZDMnZg+AM3kXRRBdQ5c/3gqQHYMBNuXg7TZQYDXPKV8M9BiePb9GTrtnrstyIb9NanebM4V4+kYdtw6INTh8PMZF8iSCHOdxUM6qpDLN/5VqyFn64m4A8wlTyGcr0cn05FmBUEmvqoUtyn3x4Q/P2iczV6ABtJBtM0abSzjuE9HW+EHj260ABYteEM/M8fOhsB7G+JYfxbmSG/IBRnrsQK3GoxQXBOoTD7F8C9DYM6AV5dBEzcuSq4ocQn9pf26cIc32L4f+Opc/lhV1cwIDAQABAoIBAEzZT70c4RnUrEc8SncaFFjbAtrBeJyY+XJNdWCkM30IU45VR7BpV3BuqmZJjOa6UmkOjReyoKFN0jTNO4IUaXEuZWXCNnRopLH6lPR+3oarOdE3J/MVTZWOSuJ1yzcl+3SjqtsycsLu/7LZRdYyabot/7+DG/bZWA6iLmKjoFWXRBMhHHHitQxX0ZrLXpgaQhqTEg1j9fGtxjEohLthtnQ12lP3/ZoTH8o2GlcjdN79EQ+CniYimo2Y5uC9j7BlmaWTrFD/IUMLDgVjJWTYqSOisuQZbqME829XVTd+gbXac9o64VphGzkAy4l2UNRDiVp4E0glEFx3ztwlX8dfuEkCgYEA4ybGqfvOrzlWZAaUMsS13EZZyJBEAKrhd/TxhY4v2A+zkYOSw921d5W/pS6yquUiwJTKEf4W4Up41wIJjbERFcy+rX9NI50tr0ogszOSKZS9CB+HIQknTrf37MEHHwx8kYzbPp6TFpZ0lkd4sVGbHDCNVwrHwuDgIeJ95p+ZQScCgYEAyYPmV4/CAoO9NWqir9RE9oqCcdo5J31fyNZjsoZa+MyooPOg+PymWT9mOuVu1HvF0MAZUp3ynidqtLpI8T9+7k2Axbky+ab31uq9oJGYcA3BuMT2O+oSiFT90HwX0zp1XtSDtygY21hJNjE+4rcMXkR6iLdx4M4Db1p8uTbDwNUCgYEAxwZcnueAqsrkRPP2uZzdc0k4taCh1KvkrcQyMkDo7rijL2ZHG9KQg1zz8/k8lrv5fR9hBe7JgVBNHKYuVLXGMIGauE2H+yJmuuWKTTlsYX5vOkTVkz5/8FsEoa5nXO8F3km6d91dJzdgo6Ovvj2wWDy6On+5k6iQ+V+HzKAeGZUCgYEAnunXYkHJ+3WsZk17kjFRWSMNj39KByxFtvnqkUSGxSGP8a1uyitje4oVsmhwKDybWO3EinRoefQXoAIvt6AdFwwjesl7u4jCdceUVuW6UtNma7FXhRQoHT75Ecpqd3boTCpG3M9QGtnaklPvhZZYuJZEE0CnG2MbLlsrdFwNrykCgYBqfDHiIk/GYipFvn/akXoCJ7zMj4PGe0TQTduSgDDcR3agwcVslOALL9nbd5ckGVYosLFLO3w5UtxEOb4Rf811BFl2vFEunYCYA2XNbJ0+2FVuFVSF5m+5APCUg6Li50MM8m5hPRF99oeJn51oohcmYb0kXIJH8b9DGBSZlbQ8UA==
154da8fe-3f06-4c3f-a7da-7c19f437c075	4e86a127-399a-4af6-a57d-49a308e9a3a1	priority	100
cc91c0b8-4c1a-4bfb-b9a6-5d5b84883b87	5f6463f4-6876-4363-95c3-a20a419ce3d5	priority	100
cbf3d43c-4ac5-4385-9804-0207abe5de6d	5f6463f4-6876-4363-95c3-a20a419ce3d5	kid	be453950-09d5-47b7-b97f-17ea985009e7
0f26a90a-668c-4d19-98de-c4a049dc2755	5f6463f4-6876-4363-95c3-a20a419ce3d5	secret	6Hnj2fDigxxm3Sam-mvmxAId6yUaQtJ_f6ExXY2L7jzEUd0JJMiWrC-f-0UhpUEn1n4IZxXQvMjE8jaObS9mupVWWdROx1WOToEFifwxaK3vfV0J8TXTFZ1q-7bPaz2uOHzN8IhvJ9K3jakQbLh0QO5bPIFr2zLqMDy-L0LrbUE
bd803d99-4fe6-4a16-904a-421a213cea30	5f6463f4-6876-4363-95c3-a20a419ce3d5	algorithm	HS512
cddaeccd-1470-4549-abca-f74379c8cca3	c2e1c3a3-05dd-47d1-a7d1-f520cd721040	secret	7uszY4b_LPLGdknO110pcN_HsRVcy0SujuDCPID7aszTqdMfU2N48pLw7pVuNaYtqxzR9FoI3NVDejJr0YRiOYf9dpWyaiFSKIhRduJupPoG9hZ2ucyTSZDPo-Q-qGNnQBKuGYCLwOKpKUP2Pi_XtO5Lz1lbtiGUPmkhoaT4Ip8
a1944364-d230-4bc7-95cb-c51da7f1c94f	c2e1c3a3-05dd-47d1-a7d1-f520cd721040	algorithm	HS256
d7aa551a-19a4-4ba3-b083-8b24fb0b117d	c2e1c3a3-05dd-47d1-a7d1-f520cd721040	priority	100
021866d9-0b20-459e-a590-77beb1ca2569	c2e1c3a3-05dd-47d1-a7d1-f520cd721040	kid	c8c6bde6-11b1-42ca-9675-fdf1dd3f146b
16acaa6c-e4db-415b-9646-8366baf70e2a	92509665-4e6a-4fac-b6b1-f69ff763cabf	privateKey	MIIEowIBAAKCAQEAvd0kVQICase5fpmxwC7FmQQx+PfYzRhwwI30bpCVcSOg9o5NEPPjqP5ueHGAydNyhKxw6rUrOHnboXpHbde/kt1MAyGzCtHNK1iu+06oLOP5EarGEGXKdktw8Mje51XSPeTMqkYc5S+ffXZbn07tKNWNPiHmwMWE1E+5GEx6zdSRbjCLbwtHY0NbU/YBgKHHr+1QJsZt+oy18yXfzycsv1BgZi4lgvzVGU2cQJDQhUXPU0JQVFpnvC8XognmacycroXNwuaOXrIwpFsMS7+xwqrQROIWyyhcYCCfuiOKtWL4edGxtVGg71utuHaxWP3mNlFbi405YB2tfO3SEygWDQIDAQABAoIBAAiwMPRu5htqzlM7x0WLHmG1LnA9Lz+babV2CYRxu1T1E22U73PiJT3bfsSmNQWHVos5tOUYq0SnVuSZyuD86XhYBh1yklXhaekc4sz/OXTsbb5gOTYQ4mXtZ9qs5n5hkABjEvaLxNC8EClWnDS7EOE4fIEmXf/eSgjJKSgyf8AhcLMo1eGUey6jPMWs2QhlSoy7E5b5OaInS0Ha1nkj15tukxNdd3R+gF+WcRti3ufPaHCFQbCjMLjDmCfTsskdzj0chjZYHwXiKaHdGWdEdR3gg3JsBfL2rAAQr6YKQG0y/gkejN21o2QFW99s25z2b10truqCf7px+tuB/Qh3xgUCgYEA/Tn3OvBX8Ff3IYahbxO9gjuJ8MHau9o20o0YCGloWrvLvc2Fk1Ya/yN5U7HktP030DITdL8sO2svF5cuU19pcCpo+dZemXeWF5DQcqiyNLGpGnTtjZuLEl+KA8tRmoA+AE+vmA+OB0yfzziTt0tZshDhoWHSC6se3wrNpPj5I3MCgYEAv/GCuNtfXUPxMfTMyUrN/x1Z3r/uobRb6fV0KYRy3rWRObEcbBt42iKo8hm6gj+5+rJozOjYWpYdtoKMIrhjvbk6VdsWvE65Hp9jDgoCyRhhHfWPQ9+T0ScHI/AGDfXbBqqjVtRp9jJrS/OpA0mliqaVtIM9gXOiE+N/0hFSgH8CgYAIB3R9W+2N41wkpf4sZXXW0Uh4Z80ls6+VUX/3lFAIwHefVwrrNwm4GUnZi4Ry8Kx6X3wacY1XfPiLSPHhFt9i/RVDBrcNKquJp7/UQuETpqZz/k0h9lKcjIb1w9acjYBpxh0NN0ELnjRa/7I/V5ZKfRqKYW2ljRF3hQIsPvC3XQKBgQCSN2QhddubrJocOCOYY4exA6bmbMdYH5C1FOo8hk0LIr1SeXzxTawuX6DbbIYLmogOVcJH9kh6GUjhM2mVOWmhqWyq4o7bPA0BKuHGXBHrJss0i09roPF1rold8wZptBP5bBuplX5ysc3SufbSLlQQ3v3D2QYNiwy4oeFJITD7+QKBgHqV2GcCkVC6GUNDb1MIH0O5L4auDTv9DzxHcSBNYEbi/DyReqElL5BD4uKsL5+qnByz5PR2LchKDFdVT3drsZVOaGG9YLLFLvnvZXJ+4O8uUrv4wKVKhRILTdOhIlG0EU78ta4wEI0r1WXuQokFp+u3yCsCUaH7QybPT/4w5IWq
318baaf4-36b0-4c44-81bf-53b625623c24	92509665-4e6a-4fac-b6b1-f69ff763cabf	algorithm	RSA-OAEP
8511ce48-1e35-4e57-9bfc-7e37b2d37aad	92509665-4e6a-4fac-b6b1-f69ff763cabf	priority	100
292fd661-61d0-4fde-9f05-3b2053b515dc	92509665-4e6a-4fac-b6b1-f69ff763cabf	certificate	MIICrzCCAZcCBgGS//Z0LzANBgkqhkiG9w0BAQsFADAbMRkwFwYDVQQDDBBUZXN0Q29tcGFueVJlYWxtMB4XDTI0MTEwNjA1MzEzNFoXDTM0MTEwNjA1MzMxNFowGzEZMBcGA1UEAwwQVGVzdENvbXBhbnlSZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL3dJFUCAmrHuX6ZscAuxZkEMfj32M0YcMCN9G6QlXEjoPaOTRDz46j+bnhxgMnTcoSscOq1Kzh526F6R23Xv5LdTAMhswrRzStYrvtOqCzj+RGqxhBlynZLcPDI3udV0j3kzKpGHOUvn312W59O7SjVjT4h5sDFhNRPuRhMes3UkW4wi28LR2NDW1P2AYChx6/tUCbGbfqMtfMl388nLL9QYGYuJYL81RlNnECQ0IVFz1NCUFRaZ7wvF6IJ5mnMnK6FzcLmjl6yMKRbDEu/scKq0ETiFssoXGAgn7ojirVi+HnRsbVRoO9brbh2sVj95jZRW4uNOWAdrXzt0hMoFg0CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEABpT+V4su0RbzT4RyZsEWqbVi3ZLpI70TFS1wslZC0SjfPtWQnZ0xq/YLG7KyzYL8/e3561s2aS3hq8iKgL0a0E6/qSIOm3fF0f7022Vj6oDF/lxyf+/K3B72XS9519nplsy9bTrYPyOBN8UrPCaczkGG59DuRyRTMvXldN2pCsRZHKJboa8Z2W/h2o+aEV8MX2R3AY6Mok/aM/WAOl2AM9f3z5hjMkt//tCkhDcpWkC5Ao60qR8fEcXp+U9aei6SdoLt5M1KgEGAO6GmjjMTcYa1sOYxm5yf16XQA6SL1WUqujBrGjfJ8hbxRdF24TlOUSs4HcLb2cUqRD5xhRoKTw==
ab0dfeff-3a05-48c8-a75d-13fdcd8ac7c7	908949c4-5f02-423d-9078-27a09befbf89	allow-default-scopes	true
74da4092-6d22-44a9-b827-3278925ade21	693693c4-7056-4c5f-83df-fa8ff6d77a56	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}
9f6e4e28-cf56-4c7d-a52c-908fed444039	56bf0d74-4422-420c-942d-5f3158d6a1e7	allowed-protocol-mapper-types	saml-role-list-mapper
e2607e95-6fdd-45f2-a926-21b49c7191ec	56bf0d74-4422-420c-942d-5f3158d6a1e7	allowed-protocol-mapper-types	oidc-full-name-mapper
bef8b7f2-2c5b-4a97-8371-a740ec8ab879	56bf0d74-4422-420c-942d-5f3158d6a1e7	allowed-protocol-mapper-types	oidc-address-mapper
1c9e27a8-9b63-4bd6-b7b6-5d6649a828ee	56bf0d74-4422-420c-942d-5f3158d6a1e7	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a61c18af-2163-43a7-8a3b-6a240a88e388	56bf0d74-4422-420c-942d-5f3158d6a1e7	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
42f666c5-46a7-4260-8477-a40fafbdfe55	56bf0d74-4422-420c-942d-5f3158d6a1e7	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
bbc94835-db32-4731-b6e7-05a8e83eaaa0	56bf0d74-4422-420c-942d-5f3158d6a1e7	allowed-protocol-mapper-types	saml-user-attribute-mapper
ba513e2e-1c7a-4821-bc4e-00b80eea40b3	56bf0d74-4422-420c-942d-5f3158d6a1e7	allowed-protocol-mapper-types	saml-user-property-mapper
274dc000-559c-41b3-887b-cb4c6f527420	bd8e2397-aaa9-4b87-94a2-1c2867e46dee	allow-default-scopes	true
2121a946-c4b3-49fb-a8b4-b281a9c0a3c0	8195bd04-09e8-4c69-99a2-5db938660664	kid	59a51bdb-2a74-4cdf-bd30-fbab4ffe860b
39f5c1ae-681e-4d77-b647-db8983c74b63	8195bd04-09e8-4c69-99a2-5db938660664	priority	100
70c2989c-e706-4a1d-8625-b97493d6b298	8195bd04-09e8-4c69-99a2-5db938660664	secret	Gjtq5tJ1HRUfPKgJQx29CA
c10fe075-0000-4bcf-9aa5-b044bdb8d1b2	1ad04d83-5569-4e7c-a9d2-de0880b77e76	allowed-protocol-mapper-types	saml-user-property-mapper
c5001538-6e4b-4ace-8463-567d591da983	1ad04d83-5569-4e7c-a9d2-de0880b77e76	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
0979d167-e5b1-4e08-842a-27f44b853eea	1ad04d83-5569-4e7c-a9d2-de0880b77e76	allowed-protocol-mapper-types	saml-role-list-mapper
8273e2e4-5830-412f-8d1b-f3e5ddba3f71	1ad04d83-5569-4e7c-a9d2-de0880b77e76	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
186b3fc0-384a-4dc5-8283-b57dfc783bd8	1ad04d83-5569-4e7c-a9d2-de0880b77e76	allowed-protocol-mapper-types	saml-user-attribute-mapper
9f519804-3fef-4b30-b1c1-5bd4af4e85d9	1ad04d83-5569-4e7c-a9d2-de0880b77e76	allowed-protocol-mapper-types	oidc-address-mapper
aa73b70c-db80-4198-91d8-0222c751a02a	1ad04d83-5569-4e7c-a9d2-de0880b77e76	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
db7ec9f5-0054-468a-a1f8-df4947d109cf	1ad04d83-5569-4e7c-a9d2-de0880b77e76	allowed-protocol-mapper-types	oidc-full-name-mapper
bce763ff-5a62-473e-9eaf-bd7a8351d37b	9bcc891b-1355-4552-a3f0-61fe304b8b72	client-uris-must-match	true
660f0026-283e-41f5-af7c-93f18e24edd1	9bcc891b-1355-4552-a3f0-61fe304b8b72	host-sending-registration-request-must-match	true
b531e5a2-c039-40dd-94ab-fcd7346ad2ca	bf1c202c-8dd4-4522-87f4-5f03b6db2038	max-clients	200
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
8928adec-228a-4cd7-992f-0605f8ee9731	a409a2f7-91b6-44f1-ace5-fc9435e9b1dc
8928adec-228a-4cd7-992f-0605f8ee9731	854f5223-41f0-4de3-a9d7-4f745006766d
8928adec-228a-4cd7-992f-0605f8ee9731	b82a6734-2217-408b-9468-5449376bd681
8928adec-228a-4cd7-992f-0605f8ee9731	f3ab66b0-c1f6-4662-9f98-4ebe75ffaf23
8928adec-228a-4cd7-992f-0605f8ee9731	16d88e8f-39dc-413d-8790-0ca2af1cfe38
8928adec-228a-4cd7-992f-0605f8ee9731	137899d8-5039-4479-98da-a513aa9101c6
8928adec-228a-4cd7-992f-0605f8ee9731	1b5f8b04-bc04-4a27-b75e-3413f25dff3d
8928adec-228a-4cd7-992f-0605f8ee9731	e11c4c84-64c0-4cbf-b570-937010d7e1dd
8928adec-228a-4cd7-992f-0605f8ee9731	b4feb632-e72f-48ff-b620-72297b1e5282
8928adec-228a-4cd7-992f-0605f8ee9731	da579d03-8990-4b84-81f1-d671dfa20301
8928adec-228a-4cd7-992f-0605f8ee9731	b09fc377-3b7d-49c8-94ff-03e3ad5e73ef
8928adec-228a-4cd7-992f-0605f8ee9731	da28365c-01c5-4527-9561-2851ee26e79f
8928adec-228a-4cd7-992f-0605f8ee9731	3953a180-2ca4-4c57-8ed8-027774bc4fc9
8928adec-228a-4cd7-992f-0605f8ee9731	c4d08266-59c0-4772-a5f7-5010dcc89a5b
8928adec-228a-4cd7-992f-0605f8ee9731	3884f20e-184c-4b17-93c3-4f4e420c65f4
8928adec-228a-4cd7-992f-0605f8ee9731	b2b1555f-067d-48ff-86cb-a5c8275aa3a4
8928adec-228a-4cd7-992f-0605f8ee9731	61794bd4-a49b-4470-ae66-4eacf7812e47
8928adec-228a-4cd7-992f-0605f8ee9731	70c12d4c-3bc0-444b-aa99-8e98c0dbdd55
16d88e8f-39dc-413d-8790-0ca2af1cfe38	b2b1555f-067d-48ff-86cb-a5c8275aa3a4
2a87b4a0-a156-49d5-9edc-9e8e0e53b699	6c4f621f-6142-41f9-a02e-46f2bf77248c
f3ab66b0-c1f6-4662-9f98-4ebe75ffaf23	70c12d4c-3bc0-444b-aa99-8e98c0dbdd55
f3ab66b0-c1f6-4662-9f98-4ebe75ffaf23	3884f20e-184c-4b17-93c3-4f4e420c65f4
2a87b4a0-a156-49d5-9edc-9e8e0e53b699	9a31d2c7-8255-4959-8621-738a101e90f9
9a31d2c7-8255-4959-8621-738a101e90f9	760ddd49-c685-47f0-9a99-43328b494dfa
fa845f0b-7c75-4e11-815a-8cd9b4f5817a	ee43ffdc-2fe7-4ea7-b4d2-7dacdd123783
8928adec-228a-4cd7-992f-0605f8ee9731	5a11465f-12cc-42b1-a289-200c5c9deb17
2a87b4a0-a156-49d5-9edc-9e8e0e53b699	406c581b-849c-4c90-b58e-c810c5c6127b
2a87b4a0-a156-49d5-9edc-9e8e0e53b699	2071fc05-5ca1-452f-a86e-63917df35a69
8928adec-228a-4cd7-992f-0605f8ee9731	1b26fe87-74ba-47d8-9330-0a627ffcb33f
8928adec-228a-4cd7-992f-0605f8ee9731	936514fc-8a4f-43d6-8845-dd5a96ea6031
8928adec-228a-4cd7-992f-0605f8ee9731	23281f82-e9e8-4ac9-8f5f-fef16a4354d3
8928adec-228a-4cd7-992f-0605f8ee9731	f517e6e4-9178-4ce0-803c-16db9b667104
8928adec-228a-4cd7-992f-0605f8ee9731	6625fae5-fb88-45ed-a2af-5836725d3d2c
8928adec-228a-4cd7-992f-0605f8ee9731	bb13157d-dc32-4bbf-be97-937f2078e7be
8928adec-228a-4cd7-992f-0605f8ee9731	af7003b0-af7b-4d89-a9cb-a2c3f26b3a9e
8928adec-228a-4cd7-992f-0605f8ee9731	04f7a80f-fe27-40c0-9974-e2d0ec097b53
8928adec-228a-4cd7-992f-0605f8ee9731	084080e2-aaeb-4c6d-af64-6597292a4d7e
8928adec-228a-4cd7-992f-0605f8ee9731	6ea785d9-e8f2-4c4d-bceb-8334fb644be8
8928adec-228a-4cd7-992f-0605f8ee9731	90fbaf47-2b15-4bf2-9a32-fb61036afdb6
8928adec-228a-4cd7-992f-0605f8ee9731	cccd4f10-e553-4ec9-9dbe-ccf5568e3476
8928adec-228a-4cd7-992f-0605f8ee9731	6d4d6352-d178-4cc3-8ed5-63cd30871916
8928adec-228a-4cd7-992f-0605f8ee9731	4ca879ff-6c04-4a88-a9ea-08f8161112f4
8928adec-228a-4cd7-992f-0605f8ee9731	f5ddeb17-e607-4631-bf4a-83a79d57671f
8928adec-228a-4cd7-992f-0605f8ee9731	47965948-b2e5-4080-930f-328c2d21bb93
8928adec-228a-4cd7-992f-0605f8ee9731	4f201e5a-72ba-4f3a-be4a-1cdd6bddbf5c
23281f82-e9e8-4ac9-8f5f-fef16a4354d3	4ca879ff-6c04-4a88-a9ea-08f8161112f4
23281f82-e9e8-4ac9-8f5f-fef16a4354d3	4f201e5a-72ba-4f3a-be4a-1cdd6bddbf5c
f517e6e4-9178-4ce0-803c-16db9b667104	f5ddeb17-e607-4631-bf4a-83a79d57671f
110c2e24-4286-4fa6-bba5-0b3535dc2a55	2418f642-0cfb-4548-9038-0a9ebe8f5134
110c2e24-4286-4fa6-bba5-0b3535dc2a55	71a4fd37-951a-4f0d-a00b-a6510b5152e4
188c431b-c4ac-4ecd-b784-278dd775b721	cf75013e-e6b9-4550-b49c-7ba07c3f9b98
3bfad9c8-a75c-418f-9217-ccb6871e7421	e2795302-0ee8-45e4-91c8-400246ef9b5b
3bfad9c8-a75c-418f-9217-ccb6871e7421	ec8ead8b-d239-452c-8cf3-99169d56a326
3bfad9c8-a75c-418f-9217-ccb6871e7421	fc307556-c8d5-4331-8267-197e96c749d2
3bfad9c8-a75c-418f-9217-ccb6871e7421	f402cad7-314b-4154-bc88-59a1b30d8742
93f5116c-eb5a-4e28-ad7d-a1dd7a31724e	a0e3fdaf-10ac-4ea2-8a54-a95bae29db18
fb6898ac-461a-4035-9f35-60771edcc3fc	0dd76cd0-a9e9-4864-af2d-61517b7b46ba
fb6898ac-461a-4035-9f35-60771edcc3fc	ca8c3a4c-16e0-48ce-87cd-baf026000313
fb6898ac-461a-4035-9f35-60771edcc3fc	5d872c94-dfe2-4f59-896b-eee9651f74b9
fb6898ac-461a-4035-9f35-60771edcc3fc	b9171e33-1819-4461-b62c-49c430b1eb2c
fb6898ac-461a-4035-9f35-60771edcc3fc	2418f642-0cfb-4548-9038-0a9ebe8f5134
fb6898ac-461a-4035-9f35-60771edcc3fc	615e2136-041e-41e6-b80b-14419a4b5804
fb6898ac-461a-4035-9f35-60771edcc3fc	110c2e24-4286-4fa6-bba5-0b3535dc2a55
fb6898ac-461a-4035-9f35-60771edcc3fc	188c431b-c4ac-4ecd-b784-278dd775b721
fb6898ac-461a-4035-9f35-60771edcc3fc	71a4fd37-951a-4f0d-a00b-a6510b5152e4
fb6898ac-461a-4035-9f35-60771edcc3fc	f94f1feb-174b-4052-8d76-c7997ed9c894
fb6898ac-461a-4035-9f35-60771edcc3fc	53499e96-a22d-473a-8dff-dbcf8f239fe8
fb6898ac-461a-4035-9f35-60771edcc3fc	f7cc1a4a-eabc-4836-a224-dd702c2775f3
fb6898ac-461a-4035-9f35-60771edcc3fc	8952c2be-f5e1-42d5-8f6a-ac3d420a836a
fb6898ac-461a-4035-9f35-60771edcc3fc	adf585b4-a559-42fd-bfda-657c8142f8c4
fb6898ac-461a-4035-9f35-60771edcc3fc	9f7fa847-289e-4197-a296-38146a5d3c5f
fb6898ac-461a-4035-9f35-60771edcc3fc	cf75013e-e6b9-4550-b49c-7ba07c3f9b98
fb6898ac-461a-4035-9f35-60771edcc3fc	899b3a45-63fa-456b-9399-fdae157df40b
fb6898ac-461a-4035-9f35-60771edcc3fc	1af4bb97-d459-48e3-bc58-e3e7c3be873d
fc307556-c8d5-4331-8267-197e96c749d2	56592dfa-ed56-4212-8ac5-4ec68265fed3
8928adec-228a-4cd7-992f-0605f8ee9731	489b83d2-0da4-40c0-9976-9324583c1a33
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
a4bc9a57-3d20-46b9-aa32-c63e6f1d17bf	\N	password	5857c2dc-a96b-4b98-9ba9-f063fbe25248	1730871196886	\N	{"value":"ur6oVTYKB4nq4lwyetHHsyv+DKfftpaMcbH+5lvoNbU=","salt":"EY/c1sXYd5GpUi+vToYapQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
ea235185-eb14-4cac-a6e2-071b00649cdf	\N	password	6b4a7c02-4407-4290-8566-41dff1624c70	1730871714757	My password	{"value":"XQBLocZjUGuy5hJ90rVk9X2AwX3IvUT3+iPfcKjEmBQ=","salt":"A8lJ0ftOfzp5uCISXHIdoQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-11-06 05:32:48.788978	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	0871167025
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-11-06 05:32:48.875108	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	0871167025
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-11-06 05:32:49.060511	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.25.1	\N	\N	0871167025
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-11-06 05:32:49.088248	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	0871167025
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-11-06 05:32:49.399945	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	0871167025
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-11-06 05:32:49.422587	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	0871167025
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-11-06 05:32:49.668522	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	0871167025
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-11-06 05:32:49.694085	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	0871167025
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-11-06 05:32:49.715689	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.25.1	\N	\N	0871167025
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-11-06 05:32:49.917332	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.25.1	\N	\N	0871167025
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-11-06 05:32:50.042926	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	0871167025
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-11-06 05:32:50.052022	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	0871167025
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-11-06 05:32:50.094682	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	0871167025
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-11-06 05:32:50.127451	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.25.1	\N	\N	0871167025
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-11-06 05:32:50.135677	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0871167025
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-11-06 05:32:50.142464	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.25.1	\N	\N	0871167025
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-11-06 05:32:50.155109	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.25.1	\N	\N	0871167025
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-11-06 05:32:50.268185	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.25.1	\N	\N	0871167025
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-11-06 05:32:50.364424	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	0871167025
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-11-06 05:32:50.37773	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	0871167025
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-11-06 05:32:50.38543	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	0871167025
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-11-06 05:32:50.392804	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	0871167025
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-11-06 05:32:50.450518	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.25.1	\N	\N	0871167025
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-11-06 05:32:50.465737	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	0871167025
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-11-06 05:32:50.468756	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	0871167025
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-11-06 05:32:50.525673	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.25.1	\N	\N	0871167025
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-11-06 05:32:50.712789	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.25.1	\N	\N	0871167025
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-11-06 05:32:50.724798	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	0871167025
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-11-06 05:32:50.898834	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.25.1	\N	\N	0871167025
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-11-06 05:32:50.933818	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.25.1	\N	\N	0871167025
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-11-06 05:32:50.98846	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.25.1	\N	\N	0871167025
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-11-06 05:32:51.0015	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.25.1	\N	\N	0871167025
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-11-06 05:32:51.01999	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0871167025
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-11-06 05:32:51.025428	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	0871167025
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-11-06 05:32:51.162745	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	0871167025
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-11-06 05:32:51.18127	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.25.1	\N	\N	0871167025
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-11-06 05:32:51.191248	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	0871167025
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-11-06 05:32:51.205136	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.25.1	\N	\N	0871167025
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-11-06 05:32:51.212983	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.25.1	\N	\N	0871167025
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-11-06 05:32:51.216835	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	0871167025
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-11-06 05:32:51.22695	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	0871167025
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-11-06 05:32:51.24228	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.25.1	\N	\N	0871167025
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-11-06 05:32:51.472337	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.25.1	\N	\N	0871167025
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-11-06 05:32:51.485702	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.25.1	\N	\N	0871167025
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-11-06 05:32:51.508753	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	0871167025
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-11-06 05:32:51.535001	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.25.1	\N	\N	0871167025
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-11-06 05:32:51.53819	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	0871167025
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-11-06 05:32:51.624031	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.25.1	\N	\N	0871167025
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-11-06 05:32:51.637689	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.25.1	\N	\N	0871167025
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-11-06 05:32:51.709048	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.25.1	\N	\N	0871167025
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-11-06 05:32:51.763815	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.25.1	\N	\N	0871167025
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-11-06 05:32:51.771583	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0871167025
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-11-06 05:32:51.77816	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.25.1	\N	\N	0871167025
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-11-06 05:32:51.782902	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.25.1	\N	\N	0871167025
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-11-06 05:32:51.794112	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.25.1	\N	\N	0871167025
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-11-06 05:32:51.803224	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.25.1	\N	\N	0871167025
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-11-06 05:32:51.845982	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.25.1	\N	\N	0871167025
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-11-06 05:32:52.067329	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.25.1	\N	\N	0871167025
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-11-06 05:32:52.160718	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.25.1	\N	\N	0871167025
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-11-06 05:32:52.196464	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	0871167025
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-11-06 05:32:52.221284	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.25.1	\N	\N	0871167025
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-11-06 05:32:52.237678	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.25.1	\N	\N	0871167025
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-11-06 05:32:52.251177	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	0871167025
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-11-06 05:32:52.264846	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	0871167025
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-11-06 05:32:52.275349	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.25.1	\N	\N	0871167025
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-11-06 05:32:52.317366	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.25.1	\N	\N	0871167025
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-11-06 05:32:52.337475	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.25.1	\N	\N	0871167025
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-11-06 05:32:52.348114	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.25.1	\N	\N	0871167025
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-11-06 05:32:52.375882	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.25.1	\N	\N	0871167025
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-11-06 05:32:52.390677	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.25.1	\N	\N	0871167025
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-11-06 05:32:52.400007	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	0871167025
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-11-06 05:32:52.423388	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	0871167025
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-11-06 05:32:52.441094	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	0871167025
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-11-06 05:32:52.447971	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	0871167025
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-11-06 05:32:52.487456	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.25.1	\N	\N	0871167025
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-11-06 05:32:52.497629	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.25.1	\N	\N	0871167025
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-11-06 05:32:52.504273	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.25.1	\N	\N	0871167025
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-11-06 05:32:52.507934	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.25.1	\N	\N	0871167025
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-11-06 05:32:52.546483	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.25.1	\N	\N	0871167025
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-11-06 05:32:52.553387	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.25.1	\N	\N	0871167025
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-11-06 05:32:52.567668	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.25.1	\N	\N	0871167025
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-11-06 05:32:52.576634	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	0871167025
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-11-06 05:32:52.594838	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	0871167025
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-11-06 05:32:52.598735	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	0871167025
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-11-06 05:32:52.613192	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	0871167025
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-11-06 05:32:52.624058	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.25.1	\N	\N	0871167025
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-11-06 05:32:52.639409	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.25.1	\N	\N	0871167025
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-11-06 05:32:52.65229	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.25.1	\N	\N	0871167025
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-11-06 05:32:52.66503	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.25.1	\N	\N	0871167025
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-11-06 05:32:52.674819	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.25.1	\N	\N	0871167025
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-11-06 05:32:52.683997	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0871167025
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-11-06 05:32:52.696286	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.25.1	\N	\N	0871167025
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-11-06 05:32:52.698931	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	0871167025
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-11-06 05:32:52.714436	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	0871167025
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-11-06 05:32:52.718696	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.25.1	\N	\N	0871167025
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-11-06 05:32:52.728319	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.25.1	\N	\N	0871167025
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-11-06 05:32:52.743592	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0871167025
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-11-06 05:32:52.746747	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0871167025
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-11-06 05:32:52.761521	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0871167025
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-11-06 05:32:52.77261	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0871167025
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-11-06 05:32:52.775316	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0871167025
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-11-06 05:32:52.786107	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.25.1	\N	\N	0871167025
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-11-06 05:32:52.79989	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.25.1	\N	\N	0871167025
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-11-06 05:32:52.809977	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.25.1	\N	\N	0871167025
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-11-06 05:32:52.823871	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.25.1	\N	\N	0871167025
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-11-06 05:32:52.836886	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.25.1	\N	\N	0871167025
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2024-11-06 05:32:52.850559	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.25.1	\N	\N	0871167025
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2024-11-06 05:32:52.870561	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.25.1	\N	\N	0871167025
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-11-06 05:32:52.884934	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	0871167025
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-11-06 05:32:52.893159	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	0871167025
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-11-06 05:32:52.909027	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0871167025
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-11-06 05:32:52.925978	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	0871167025
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-11-06 05:32:52.964181	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	0871167025
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-11-06 05:32:52.969132	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	0871167025
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-11-06 05:32:52.98175	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	0871167025
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-11-06 05:32:52.988169	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	0871167025
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-11-06 05:32:53.002359	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	0871167025
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-11-06 05:32:53.010263	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	0871167025
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-11-06 05:32:53.03693	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	0871167025
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-11-06 05:32:53.047796	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	0871167025
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-11-06 05:32:53.05552	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0871167025
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-11-06 05:32:53.067135	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0871167025
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-11-06 05:32:53.075891	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	0871167025
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-11-06 05:32:53.078905	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0871167025
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-11-06 05:32:53.082593	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0871167025
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-06 05:32:53.09176	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.25.1	\N	\N	0871167025
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-06 05:32:53.105054	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0871167025
25.0.0-28265-index-cleanup	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-06 05:32:53.117935	128	EXECUTED	9:8c0cfa341a0474385b324f5c4b2dfcc1	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...		\N	4.25.1	\N	\N	0871167025
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-06 05:32:53.122236	129	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0871167025
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-06 05:32:53.133377	130	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0871167025
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-06 05:32:53.170855	131	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.25.1	\N	\N	0871167025
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-06 05:32:53.192985	132	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	0871167025
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-06 05:32:53.195601	133	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	0871167025
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-11-06 05:32:53.208163	134	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.25.1	\N	\N	0871167025
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
1188f655-9676-4630-ba0e-451e8cbc5697	8e239cf6-2408-4c62-bcf8-0d10acb2a45b	f
1188f655-9676-4630-ba0e-451e8cbc5697	fa3b49a4-2e53-43be-9f98-1344e5d79207	t
1188f655-9676-4630-ba0e-451e8cbc5697	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9	t
1188f655-9676-4630-ba0e-451e8cbc5697	f7ca2e9d-d959-41f6-8ab8-71703e1e09a6	t
1188f655-9676-4630-ba0e-451e8cbc5697	279f3670-aa45-40a8-ab87-e1e987c131b5	f
1188f655-9676-4630-ba0e-451e8cbc5697	0bbbf6cd-0807-45e6-8814-dfe44200f5a8	f
1188f655-9676-4630-ba0e-451e8cbc5697	9ab24742-a022-47d1-ad7a-698eb22a2c90	t
1188f655-9676-4630-ba0e-451e8cbc5697	b4efce83-2cee-432d-9b8c-eddddbce074a	t
1188f655-9676-4630-ba0e-451e8cbc5697	4ccf17fe-0bbb-4683-a121-19880aa8fd2d	f
1188f655-9676-4630-ba0e-451e8cbc5697	ac211429-43b9-43aa-81d7-a6c886641fa8	t
1188f655-9676-4630-ba0e-451e8cbc5697	dc5cacff-c5cf-4fc2-8536-20b0fbbc1bee	t
0ff635a9-4a9c-47af-8eec-860d88e871e8	e7947f94-14db-454c-9696-7dad601e9a77	t
0ff635a9-4a9c-47af-8eec-860d88e871e8	286d34ba-2b51-4c9c-af5b-86a057aece86	t
0ff635a9-4a9c-47af-8eec-860d88e871e8	24465872-0b69-4add-ae8f-1f99428eb6ba	t
0ff635a9-4a9c-47af-8eec-860d88e871e8	41c99aee-bc3a-4911-92f6-19ea81a0b8c7	t
0ff635a9-4a9c-47af-8eec-860d88e871e8	dbcd7999-b789-420c-b217-77f23844ac15	t
0ff635a9-4a9c-47af-8eec-860d88e871e8	5be4e042-446b-4ed0-9f16-d452e059de9d	t
0ff635a9-4a9c-47af-8eec-860d88e871e8	3b5722d1-34d4-4b0a-884a-e72be27bc0e1	t
0ff635a9-4a9c-47af-8eec-860d88e871e8	04804ea5-24cd-4ecd-a5ba-3c04b571642a	f
0ff635a9-4a9c-47af-8eec-860d88e871e8	f9fb13b2-0b16-40a9-bf29-3996c78a1daa	f
0ff635a9-4a9c-47af-8eec-860d88e871e8	7ebc8ff0-51f5-4db3-acec-94465d76eacc	f
0ff635a9-4a9c-47af-8eec-860d88e871e8	bb65e029-32ef-4b42-b112-da44ded26610	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
2a87b4a0-a156-49d5-9edc-9e8e0e53b699	1188f655-9676-4630-ba0e-451e8cbc5697	f	${role_default-roles}	default-roles-master	1188f655-9676-4630-ba0e-451e8cbc5697	\N	\N
8928adec-228a-4cd7-992f-0605f8ee9731	1188f655-9676-4630-ba0e-451e8cbc5697	f	${role_admin}	admin	1188f655-9676-4630-ba0e-451e8cbc5697	\N	\N
a409a2f7-91b6-44f1-ace5-fc9435e9b1dc	1188f655-9676-4630-ba0e-451e8cbc5697	f	${role_create-realm}	create-realm	1188f655-9676-4630-ba0e-451e8cbc5697	\N	\N
854f5223-41f0-4de3-a9d7-4f745006766d	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_create-client}	create-client	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
b82a6734-2217-408b-9468-5449376bd681	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_view-realm}	view-realm	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
f3ab66b0-c1f6-4662-9f98-4ebe75ffaf23	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_view-users}	view-users	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
16d88e8f-39dc-413d-8790-0ca2af1cfe38	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_view-clients}	view-clients	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
137899d8-5039-4479-98da-a513aa9101c6	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_view-events}	view-events	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
1b5f8b04-bc04-4a27-b75e-3413f25dff3d	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_view-identity-providers}	view-identity-providers	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
e11c4c84-64c0-4cbf-b570-937010d7e1dd	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_view-authorization}	view-authorization	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
b4feb632-e72f-48ff-b620-72297b1e5282	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_manage-realm}	manage-realm	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
da579d03-8990-4b84-81f1-d671dfa20301	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_manage-users}	manage-users	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
b09fc377-3b7d-49c8-94ff-03e3ad5e73ef	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_manage-clients}	manage-clients	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
da28365c-01c5-4527-9561-2851ee26e79f	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_manage-events}	manage-events	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
3953a180-2ca4-4c57-8ed8-027774bc4fc9	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_manage-identity-providers}	manage-identity-providers	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
c4d08266-59c0-4772-a5f7-5010dcc89a5b	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_manage-authorization}	manage-authorization	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
3884f20e-184c-4b17-93c3-4f4e420c65f4	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_query-users}	query-users	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
b2b1555f-067d-48ff-86cb-a5c8275aa3a4	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_query-clients}	query-clients	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
61794bd4-a49b-4470-ae66-4eacf7812e47	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_query-realms}	query-realms	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
70c12d4c-3bc0-444b-aa99-8e98c0dbdd55	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_query-groups}	query-groups	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
6c4f621f-6142-41f9-a02e-46f2bf77248c	248766fb-d320-4a79-8a16-6567674baffd	t	${role_view-profile}	view-profile	1188f655-9676-4630-ba0e-451e8cbc5697	248766fb-d320-4a79-8a16-6567674baffd	\N
9a31d2c7-8255-4959-8621-738a101e90f9	248766fb-d320-4a79-8a16-6567674baffd	t	${role_manage-account}	manage-account	1188f655-9676-4630-ba0e-451e8cbc5697	248766fb-d320-4a79-8a16-6567674baffd	\N
760ddd49-c685-47f0-9a99-43328b494dfa	248766fb-d320-4a79-8a16-6567674baffd	t	${role_manage-account-links}	manage-account-links	1188f655-9676-4630-ba0e-451e8cbc5697	248766fb-d320-4a79-8a16-6567674baffd	\N
9bc8c698-caa1-420c-b7ed-e961bb0a59db	248766fb-d320-4a79-8a16-6567674baffd	t	${role_view-applications}	view-applications	1188f655-9676-4630-ba0e-451e8cbc5697	248766fb-d320-4a79-8a16-6567674baffd	\N
ee43ffdc-2fe7-4ea7-b4d2-7dacdd123783	248766fb-d320-4a79-8a16-6567674baffd	t	${role_view-consent}	view-consent	1188f655-9676-4630-ba0e-451e8cbc5697	248766fb-d320-4a79-8a16-6567674baffd	\N
fa845f0b-7c75-4e11-815a-8cd9b4f5817a	248766fb-d320-4a79-8a16-6567674baffd	t	${role_manage-consent}	manage-consent	1188f655-9676-4630-ba0e-451e8cbc5697	248766fb-d320-4a79-8a16-6567674baffd	\N
9c621830-6ae4-45fc-a032-b7b093356a72	248766fb-d320-4a79-8a16-6567674baffd	t	${role_view-groups}	view-groups	1188f655-9676-4630-ba0e-451e8cbc5697	248766fb-d320-4a79-8a16-6567674baffd	\N
3dc94114-5e01-4a7a-b802-73502c3f352d	248766fb-d320-4a79-8a16-6567674baffd	t	${role_delete-account}	delete-account	1188f655-9676-4630-ba0e-451e8cbc5697	248766fb-d320-4a79-8a16-6567674baffd	\N
e5ccf380-acd3-43b7-84c2-4b7b76b42b5c	a6d97eed-774b-46cd-9d6b-05f70534bb6d	t	${role_read-token}	read-token	1188f655-9676-4630-ba0e-451e8cbc5697	a6d97eed-774b-46cd-9d6b-05f70534bb6d	\N
5a11465f-12cc-42b1-a289-200c5c9deb17	433248d8-6ac7-475a-a9cd-6a7977a2c034	t	${role_impersonation}	impersonation	1188f655-9676-4630-ba0e-451e8cbc5697	433248d8-6ac7-475a-a9cd-6a7977a2c034	\N
406c581b-849c-4c90-b58e-c810c5c6127b	1188f655-9676-4630-ba0e-451e8cbc5697	f	${role_offline-access}	offline_access	1188f655-9676-4630-ba0e-451e8cbc5697	\N	\N
2071fc05-5ca1-452f-a86e-63917df35a69	1188f655-9676-4630-ba0e-451e8cbc5697	f	${role_uma_authorization}	uma_authorization	1188f655-9676-4630-ba0e-451e8cbc5697	\N	\N
3bfad9c8-a75c-418f-9217-ccb6871e7421	0ff635a9-4a9c-47af-8eec-860d88e871e8	f	${role_default-roles}	default-roles-testcompanyrealm	0ff635a9-4a9c-47af-8eec-860d88e871e8	\N	\N
1b26fe87-74ba-47d8-9330-0a627ffcb33f	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_create-client}	create-client	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
936514fc-8a4f-43d6-8845-dd5a96ea6031	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_view-realm}	view-realm	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
23281f82-e9e8-4ac9-8f5f-fef16a4354d3	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_view-users}	view-users	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
f517e6e4-9178-4ce0-803c-16db9b667104	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_view-clients}	view-clients	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
6625fae5-fb88-45ed-a2af-5836725d3d2c	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_view-events}	view-events	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
bb13157d-dc32-4bbf-be97-937f2078e7be	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_view-identity-providers}	view-identity-providers	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
af7003b0-af7b-4d89-a9cb-a2c3f26b3a9e	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_view-authorization}	view-authorization	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
04f7a80f-fe27-40c0-9974-e2d0ec097b53	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_manage-realm}	manage-realm	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
084080e2-aaeb-4c6d-af64-6597292a4d7e	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_manage-users}	manage-users	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
6ea785d9-e8f2-4c4d-bceb-8334fb644be8	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_manage-clients}	manage-clients	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
90fbaf47-2b15-4bf2-9a32-fb61036afdb6	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_manage-events}	manage-events	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
cccd4f10-e553-4ec9-9dbe-ccf5568e3476	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_manage-identity-providers}	manage-identity-providers	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
6d4d6352-d178-4cc3-8ed5-63cd30871916	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_manage-authorization}	manage-authorization	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
4ca879ff-6c04-4a88-a9ea-08f8161112f4	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_query-users}	query-users	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
f5ddeb17-e607-4631-bf4a-83a79d57671f	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_query-clients}	query-clients	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
47965948-b2e5-4080-930f-328c2d21bb93	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_query-realms}	query-realms	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
4f201e5a-72ba-4f3a-be4a-1cdd6bddbf5c	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_query-groups}	query-groups	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
543f1ce5-570a-4d06-97f3-1db040a47c04	0ff635a9-4a9c-47af-8eec-860d88e871e8	f		admin_role	0ff635a9-4a9c-47af-8eec-860d88e871e8	\N	\N
e2795302-0ee8-45e4-91c8-400246ef9b5b	0ff635a9-4a9c-47af-8eec-860d88e871e8	f	${role_offline-access}	offline_access	0ff635a9-4a9c-47af-8eec-860d88e871e8	\N	\N
f402cad7-314b-4154-bc88-59a1b30d8742	0ff635a9-4a9c-47af-8eec-860d88e871e8	f	${role_uma_authorization}	uma_authorization	0ff635a9-4a9c-47af-8eec-860d88e871e8	\N	\N
0dd76cd0-a9e9-4864-af2d-61517b7b46ba	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_manage-events}	manage-events	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
ca8c3a4c-16e0-48ce-87cd-baf026000313	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_manage-users}	manage-users	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
5d872c94-dfe2-4f59-896b-eee9651f74b9	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_manage-authorization}	manage-authorization	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
b9171e33-1819-4461-b62c-49c430b1eb2c	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_manage-identity-providers}	manage-identity-providers	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
2418f642-0cfb-4548-9038-0a9ebe8f5134	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_query-groups}	query-groups	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
615e2136-041e-41e6-b80b-14419a4b5804	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_manage-clients}	manage-clients	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
110c2e24-4286-4fa6-bba5-0b3535dc2a55	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_view-users}	view-users	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
188c431b-c4ac-4ecd-b784-278dd775b721	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_view-clients}	view-clients	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
71a4fd37-951a-4f0d-a00b-a6510b5152e4	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_query-users}	query-users	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
f94f1feb-174b-4052-8d76-c7997ed9c894	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_impersonation}	impersonation	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
53499e96-a22d-473a-8dff-dbcf8f239fe8	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_view-authorization}	view-authorization	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
f7cc1a4a-eabc-4836-a224-dd702c2775f3	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_manage-realm}	manage-realm	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
8952c2be-f5e1-42d5-8f6a-ac3d420a836a	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_view-identity-providers}	view-identity-providers	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
adf585b4-a559-42fd-bfda-657c8142f8c4	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_create-client}	create-client	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
9f7fa847-289e-4197-a296-38146a5d3c5f	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_view-realm}	view-realm	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
cf75013e-e6b9-4550-b49c-7ba07c3f9b98	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_query-clients}	query-clients	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
fb6898ac-461a-4035-9f35-60771edcc3fc	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_realm-admin}	realm-admin	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
899b3a45-63fa-456b-9399-fdae157df40b	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_view-events}	view-events	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
1af4bb97-d459-48e3-bc58-e3e7c3be873d	810f8ebf-9023-4c80-a734-65b7ee07eb63	t	${role_query-realms}	query-realms	0ff635a9-4a9c-47af-8eec-860d88e871e8	810f8ebf-9023-4c80-a734-65b7ee07eb63	\N
df957d00-2623-4f97-9067-18366fc3db5d	5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	t	${role_read-token}	read-token	0ff635a9-4a9c-47af-8eec-860d88e871e8	5e84fcfe-9f0f-4c06-9c7b-00b1223855ba	\N
b673fe95-750b-4d27-94e4-86166d297405	91089183-fce3-4047-a65d-ee0d02228343	t	${role_view-groups}	view-groups	0ff635a9-4a9c-47af-8eec-860d88e871e8	91089183-fce3-4047-a65d-ee0d02228343	\N
8866023d-fd09-4d95-bdc9-f9960d8a5cd3	91089183-fce3-4047-a65d-ee0d02228343	t	${role_view-applications}	view-applications	0ff635a9-4a9c-47af-8eec-860d88e871e8	91089183-fce3-4047-a65d-ee0d02228343	\N
93f5116c-eb5a-4e28-ad7d-a1dd7a31724e	91089183-fce3-4047-a65d-ee0d02228343	t	${role_manage-consent}	manage-consent	0ff635a9-4a9c-47af-8eec-860d88e871e8	91089183-fce3-4047-a65d-ee0d02228343	\N
a0e3fdaf-10ac-4ea2-8a54-a95bae29db18	91089183-fce3-4047-a65d-ee0d02228343	t	${role_view-consent}	view-consent	0ff635a9-4a9c-47af-8eec-860d88e871e8	91089183-fce3-4047-a65d-ee0d02228343	\N
ec8ead8b-d239-452c-8cf3-99169d56a326	91089183-fce3-4047-a65d-ee0d02228343	t	${role_view-profile}	view-profile	0ff635a9-4a9c-47af-8eec-860d88e871e8	91089183-fce3-4047-a65d-ee0d02228343	\N
e9057985-46b5-4d68-b7c4-c8513d312e9e	91089183-fce3-4047-a65d-ee0d02228343	t	${role_delete-account}	delete-account	0ff635a9-4a9c-47af-8eec-860d88e871e8	91089183-fce3-4047-a65d-ee0d02228343	\N
56592dfa-ed56-4212-8ac5-4ec68265fed3	91089183-fce3-4047-a65d-ee0d02228343	t	${role_manage-account-links}	manage-account-links	0ff635a9-4a9c-47af-8eec-860d88e871e8	91089183-fce3-4047-a65d-ee0d02228343	\N
fc307556-c8d5-4331-8267-197e96c749d2	91089183-fce3-4047-a65d-ee0d02228343	t	${role_manage-account}	manage-account	0ff635a9-4a9c-47af-8eec-860d88e871e8	91089183-fce3-4047-a65d-ee0d02228343	\N
489b83d2-0da4-40c0-9976-9324583c1a33	0268cef5-ed1c-4f38-8eb1-675068670e01	t	${role_impersonation}	impersonation	1188f655-9676-4630-ba0e-451e8cbc5697	0268cef5-ed1c-4f38-8eb1-675068670e01	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
bdfgq	25.0.2	1730871173
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org (id, enabled, realm_id, group_id, name, description) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
aef57dbc-c056-4af5-9d8b-638700635a15	audience resolve	openid-connect	oidc-audience-resolve-mapper	44f5bda9-56dc-4dfd-aafc-a29f383c30fd	\N
a73217bf-cbfd-4513-9371-07d3363c4a49	locale	openid-connect	oidc-usermodel-attribute-mapper	bdb9f6b6-db26-459a-a8b8-c2997e622ac8	\N
7b01597a-3444-4aaa-9684-b97f9ce365da	role list	saml	saml-role-list-mapper	\N	fa3b49a4-2e53-43be-9f98-1344e5d79207
bb818336-192c-4d69-ae47-3710c4621ff3	full name	openid-connect	oidc-full-name-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
a0ed1138-4c23-46b7-863e-46b81fb216bf	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
300160ea-1709-42a6-96af-2554f58a4d46	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
df360529-8f08-476a-849a-c2b5075c730d	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
0da64f99-c155-4617-8cc2-fc03bfdb066a	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
8c6fccb5-4ba6-4500-a193-85f1ef25531e	username	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
dabd098e-13c6-4d2a-b43b-5859f01b2948	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
61a45650-aedb-4811-8d56-479ebcc10c28	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
83997634-72fe-4be0-9275-898050b5db4b	website	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
969a5eac-29b6-4057-9862-11925571e63b	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
ab9dfa77-ddbf-4592-ade3-275fbff53c9d	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
d9ab9731-b7ef-44cf-8683-b6761c3d7a62	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
0b5aae38-6c37-488e-885f-c2c04fafee3d	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
8a099dba-b85b-4887-9661-a9ec9a4b9e18	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c7d8f4-0f6f-4cbe-828b-9dbfce3bedd9
af1c910c-73e3-4986-b6e2-5e26b5cebb76	email	openid-connect	oidc-usermodel-attribute-mapper	\N	f7ca2e9d-d959-41f6-8ab8-71703e1e09a6
933bcc2c-7bda-4f6b-a1f2-9455a984a1af	email verified	openid-connect	oidc-usermodel-property-mapper	\N	f7ca2e9d-d959-41f6-8ab8-71703e1e09a6
fff2dab6-1656-45a1-a0cf-d51fe1cb0c9b	address	openid-connect	oidc-address-mapper	\N	279f3670-aa45-40a8-ab87-e1e987c131b5
a37cec13-fa4b-4cc5-9f63-196ea3a41c92	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	0bbbf6cd-0807-45e6-8814-dfe44200f5a8
8bef54c9-85e9-42c4-a27f-4f140fcac8f1	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	0bbbf6cd-0807-45e6-8814-dfe44200f5a8
a706e669-4f37-4264-b04f-ae87aa094e5c	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	9ab24742-a022-47d1-ad7a-698eb22a2c90
b34f7f51-4c07-4b9b-a9b8-8c2d61878b24	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	9ab24742-a022-47d1-ad7a-698eb22a2c90
29adf596-d51b-48de-8747-9520f5a2319c	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	9ab24742-a022-47d1-ad7a-698eb22a2c90
05a07e3d-7b37-494e-b6ab-dc1fd9e53db4	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	b4efce83-2cee-432d-9b8c-eddddbce074a
2d1482bc-f84e-45c3-abab-def27d7ce036	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	4ccf17fe-0bbb-4683-a121-19880aa8fd2d
8c7a3980-148a-4328-a4e4-85d11893e7ab	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	4ccf17fe-0bbb-4683-a121-19880aa8fd2d
8a3a45cb-9a1b-437f-a062-cade24404a71	acr loa level	openid-connect	oidc-acr-mapper	\N	ac211429-43b9-43aa-81d7-a6c886641fa8
d2e7ba76-0c83-41e8-97c9-a63af28314fc	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	dc5cacff-c5cf-4fc2-8536-20b0fbbc1bee
7a5fd19c-dfa7-4a5d-af81-dab737b47994	sub	openid-connect	oidc-sub-mapper	\N	dc5cacff-c5cf-4fc2-8536-20b0fbbc1bee
3b6a0297-85af-4ae0-9fd0-3e85b1d89c08	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	41c99aee-bc3a-4911-92f6-19ea81a0b8c7
8c2582ba-4e8f-4b39-a116-ca954535a770	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	41c99aee-bc3a-4911-92f6-19ea81a0b8c7
94418ad3-3c32-4d2d-a093-562f8b36ee10	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	41c99aee-bc3a-4911-92f6-19ea81a0b8c7
5dbf54bf-f5b9-4361-9669-6796a515ef33	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	3b5722d1-34d4-4b0a-884a-e72be27bc0e1
9cea473c-40fc-4561-8615-8275570e67a8	sub	openid-connect	oidc-sub-mapper	\N	3b5722d1-34d4-4b0a-884a-e72be27bc0e1
f49325a5-e360-4700-a7d0-727af85c6f5a	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	7ebc8ff0-51f5-4db3-acec-94465d76eacc
79994c8b-ee3f-42dc-9c7b-362ae2674b33	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	7ebc8ff0-51f5-4db3-acec-94465d76eacc
6c363dd0-1aaf-4689-9749-3e0d3c02b963	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	bb65e029-32ef-4b42-b112-da44ded26610
4a8f4c7c-56ec-476b-9d13-1e9f3454c6fb	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	bb65e029-32ef-4b42-b112-da44ded26610
5947e4bb-c81e-4549-b426-3eac584b9e87	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	dbcd7999-b789-420c-b217-77f23844ac15
31da9e7a-2ffd-41a2-a381-26172028de2e	acr loa level	openid-connect	oidc-acr-mapper	\N	5be4e042-446b-4ed0-9f16-d452e059de9d
f471b384-3ef9-493f-8d93-027fd503c11a	role list	saml	saml-role-list-mapper	\N	e7947f94-14db-454c-9696-7dad601e9a77
70fedac6-9ade-4c0b-ba25-fe8c70fbc1d2	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
ac813ab0-5936-46ef-a8ba-59bc862f1915	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
4587fee8-e1cc-45eb-b047-6b5c56968cf1	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
bf7d2af2-7ff2-440c-9c5e-968bc3b14694	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
6fd19163-2fc3-4afc-9dfb-2afbc2e73fdb	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
634dc2f4-37f6-4ed9-9701-706993560c27	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
575eef97-85f0-42d0-a784-dd9f45639c7b	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
8376de16-8509-4102-b513-b10bba874454	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
33de2a4b-846c-4781-ae98-b5e135933bcf	full name	openid-connect	oidc-full-name-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
b3abaad5-b7c5-49cd-8769-3a8579e7a68f	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
b5ab6fa5-dc61-4fd7-88e3-af054814ae3b	username	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
6444950b-4184-433a-9173-3830b43a7c60	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
66fd2062-1f53-4153-9919-9051e637dd3a	website	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
0d177c32-c17d-43c5-a783-f5f23fa73ec9	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	286d34ba-2b51-4c9c-af5b-86a057aece86
aba18f62-c3dc-45f5-aaab-e7426708c408	email verified	openid-connect	oidc-usermodel-property-mapper	\N	24465872-0b69-4add-ae8f-1f99428eb6ba
2d8994c5-fd03-4008-bf59-68ba7191c95c	email	openid-connect	oidc-usermodel-attribute-mapper	\N	24465872-0b69-4add-ae8f-1f99428eb6ba
142c9dc8-6910-46a5-ab0f-d05b06dab26c	address	openid-connect	oidc-address-mapper	\N	f9fb13b2-0b16-40a9-bf29-3996c78a1daa
71d69ad8-1a8f-483c-9176-b1a92149c547	audience resolve	openid-connect	oidc-audience-resolve-mapper	3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	\N
0e4cb6e0-4d4a-434e-9586-edb8ca7e3a89	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	6368b30f-a0a7-4c96-bd53-7cea84ed0efe	\N
8c2eb44f-444d-4fe6-bbf8-1598a7d91028	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	6368b30f-a0a7-4c96-bd53-7cea84ed0efe	\N
dd8d163c-4e92-4434-8d1f-9966f3ac6ab0	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	6368b30f-a0a7-4c96-bd53-7cea84ed0efe	\N
78fba238-bf0d-4c0b-9788-04bdec87434d	locale	openid-connect	oidc-usermodel-attribute-mapper	61ae9827-8300-4046-a78b-6fc1df466f66	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
a73217bf-cbfd-4513-9371-07d3363c4a49	true	introspection.token.claim
a73217bf-cbfd-4513-9371-07d3363c4a49	true	userinfo.token.claim
a73217bf-cbfd-4513-9371-07d3363c4a49	locale	user.attribute
a73217bf-cbfd-4513-9371-07d3363c4a49	true	id.token.claim
a73217bf-cbfd-4513-9371-07d3363c4a49	true	access.token.claim
a73217bf-cbfd-4513-9371-07d3363c4a49	locale	claim.name
a73217bf-cbfd-4513-9371-07d3363c4a49	String	jsonType.label
7b01597a-3444-4aaa-9684-b97f9ce365da	false	single
7b01597a-3444-4aaa-9684-b97f9ce365da	Basic	attribute.nameformat
7b01597a-3444-4aaa-9684-b97f9ce365da	Role	attribute.name
0b5aae38-6c37-488e-885f-c2c04fafee3d	true	introspection.token.claim
0b5aae38-6c37-488e-885f-c2c04fafee3d	true	userinfo.token.claim
0b5aae38-6c37-488e-885f-c2c04fafee3d	locale	user.attribute
0b5aae38-6c37-488e-885f-c2c04fafee3d	true	id.token.claim
0b5aae38-6c37-488e-885f-c2c04fafee3d	true	access.token.claim
0b5aae38-6c37-488e-885f-c2c04fafee3d	locale	claim.name
0b5aae38-6c37-488e-885f-c2c04fafee3d	String	jsonType.label
0da64f99-c155-4617-8cc2-fc03bfdb066a	true	introspection.token.claim
0da64f99-c155-4617-8cc2-fc03bfdb066a	true	userinfo.token.claim
0da64f99-c155-4617-8cc2-fc03bfdb066a	nickname	user.attribute
0da64f99-c155-4617-8cc2-fc03bfdb066a	true	id.token.claim
0da64f99-c155-4617-8cc2-fc03bfdb066a	true	access.token.claim
0da64f99-c155-4617-8cc2-fc03bfdb066a	nickname	claim.name
0da64f99-c155-4617-8cc2-fc03bfdb066a	String	jsonType.label
300160ea-1709-42a6-96af-2554f58a4d46	true	introspection.token.claim
300160ea-1709-42a6-96af-2554f58a4d46	true	userinfo.token.claim
300160ea-1709-42a6-96af-2554f58a4d46	firstName	user.attribute
300160ea-1709-42a6-96af-2554f58a4d46	true	id.token.claim
300160ea-1709-42a6-96af-2554f58a4d46	true	access.token.claim
300160ea-1709-42a6-96af-2554f58a4d46	given_name	claim.name
300160ea-1709-42a6-96af-2554f58a4d46	String	jsonType.label
61a45650-aedb-4811-8d56-479ebcc10c28	true	introspection.token.claim
61a45650-aedb-4811-8d56-479ebcc10c28	true	userinfo.token.claim
61a45650-aedb-4811-8d56-479ebcc10c28	picture	user.attribute
61a45650-aedb-4811-8d56-479ebcc10c28	true	id.token.claim
61a45650-aedb-4811-8d56-479ebcc10c28	true	access.token.claim
61a45650-aedb-4811-8d56-479ebcc10c28	picture	claim.name
61a45650-aedb-4811-8d56-479ebcc10c28	String	jsonType.label
83997634-72fe-4be0-9275-898050b5db4b	true	introspection.token.claim
83997634-72fe-4be0-9275-898050b5db4b	true	userinfo.token.claim
83997634-72fe-4be0-9275-898050b5db4b	website	user.attribute
83997634-72fe-4be0-9275-898050b5db4b	true	id.token.claim
83997634-72fe-4be0-9275-898050b5db4b	true	access.token.claim
83997634-72fe-4be0-9275-898050b5db4b	website	claim.name
83997634-72fe-4be0-9275-898050b5db4b	String	jsonType.label
8a099dba-b85b-4887-9661-a9ec9a4b9e18	true	introspection.token.claim
8a099dba-b85b-4887-9661-a9ec9a4b9e18	true	userinfo.token.claim
8a099dba-b85b-4887-9661-a9ec9a4b9e18	updatedAt	user.attribute
8a099dba-b85b-4887-9661-a9ec9a4b9e18	true	id.token.claim
8a099dba-b85b-4887-9661-a9ec9a4b9e18	true	access.token.claim
8a099dba-b85b-4887-9661-a9ec9a4b9e18	updated_at	claim.name
8a099dba-b85b-4887-9661-a9ec9a4b9e18	long	jsonType.label
8c6fccb5-4ba6-4500-a193-85f1ef25531e	true	introspection.token.claim
8c6fccb5-4ba6-4500-a193-85f1ef25531e	true	userinfo.token.claim
8c6fccb5-4ba6-4500-a193-85f1ef25531e	username	user.attribute
8c6fccb5-4ba6-4500-a193-85f1ef25531e	true	id.token.claim
8c6fccb5-4ba6-4500-a193-85f1ef25531e	true	access.token.claim
8c6fccb5-4ba6-4500-a193-85f1ef25531e	preferred_username	claim.name
8c6fccb5-4ba6-4500-a193-85f1ef25531e	String	jsonType.label
969a5eac-29b6-4057-9862-11925571e63b	true	introspection.token.claim
969a5eac-29b6-4057-9862-11925571e63b	true	userinfo.token.claim
969a5eac-29b6-4057-9862-11925571e63b	gender	user.attribute
969a5eac-29b6-4057-9862-11925571e63b	true	id.token.claim
969a5eac-29b6-4057-9862-11925571e63b	true	access.token.claim
969a5eac-29b6-4057-9862-11925571e63b	gender	claim.name
969a5eac-29b6-4057-9862-11925571e63b	String	jsonType.label
a0ed1138-4c23-46b7-863e-46b81fb216bf	true	introspection.token.claim
a0ed1138-4c23-46b7-863e-46b81fb216bf	true	userinfo.token.claim
a0ed1138-4c23-46b7-863e-46b81fb216bf	lastName	user.attribute
a0ed1138-4c23-46b7-863e-46b81fb216bf	true	id.token.claim
a0ed1138-4c23-46b7-863e-46b81fb216bf	true	access.token.claim
a0ed1138-4c23-46b7-863e-46b81fb216bf	family_name	claim.name
a0ed1138-4c23-46b7-863e-46b81fb216bf	String	jsonType.label
ab9dfa77-ddbf-4592-ade3-275fbff53c9d	true	introspection.token.claim
ab9dfa77-ddbf-4592-ade3-275fbff53c9d	true	userinfo.token.claim
ab9dfa77-ddbf-4592-ade3-275fbff53c9d	birthdate	user.attribute
ab9dfa77-ddbf-4592-ade3-275fbff53c9d	true	id.token.claim
ab9dfa77-ddbf-4592-ade3-275fbff53c9d	true	access.token.claim
ab9dfa77-ddbf-4592-ade3-275fbff53c9d	birthdate	claim.name
ab9dfa77-ddbf-4592-ade3-275fbff53c9d	String	jsonType.label
bb818336-192c-4d69-ae47-3710c4621ff3	true	introspection.token.claim
bb818336-192c-4d69-ae47-3710c4621ff3	true	userinfo.token.claim
bb818336-192c-4d69-ae47-3710c4621ff3	true	id.token.claim
bb818336-192c-4d69-ae47-3710c4621ff3	true	access.token.claim
d9ab9731-b7ef-44cf-8683-b6761c3d7a62	true	introspection.token.claim
d9ab9731-b7ef-44cf-8683-b6761c3d7a62	true	userinfo.token.claim
d9ab9731-b7ef-44cf-8683-b6761c3d7a62	zoneinfo	user.attribute
d9ab9731-b7ef-44cf-8683-b6761c3d7a62	true	id.token.claim
d9ab9731-b7ef-44cf-8683-b6761c3d7a62	true	access.token.claim
d9ab9731-b7ef-44cf-8683-b6761c3d7a62	zoneinfo	claim.name
d9ab9731-b7ef-44cf-8683-b6761c3d7a62	String	jsonType.label
dabd098e-13c6-4d2a-b43b-5859f01b2948	true	introspection.token.claim
dabd098e-13c6-4d2a-b43b-5859f01b2948	true	userinfo.token.claim
dabd098e-13c6-4d2a-b43b-5859f01b2948	profile	user.attribute
dabd098e-13c6-4d2a-b43b-5859f01b2948	true	id.token.claim
dabd098e-13c6-4d2a-b43b-5859f01b2948	true	access.token.claim
dabd098e-13c6-4d2a-b43b-5859f01b2948	profile	claim.name
dabd098e-13c6-4d2a-b43b-5859f01b2948	String	jsonType.label
df360529-8f08-476a-849a-c2b5075c730d	true	introspection.token.claim
df360529-8f08-476a-849a-c2b5075c730d	true	userinfo.token.claim
df360529-8f08-476a-849a-c2b5075c730d	middleName	user.attribute
df360529-8f08-476a-849a-c2b5075c730d	true	id.token.claim
df360529-8f08-476a-849a-c2b5075c730d	true	access.token.claim
df360529-8f08-476a-849a-c2b5075c730d	middle_name	claim.name
df360529-8f08-476a-849a-c2b5075c730d	String	jsonType.label
933bcc2c-7bda-4f6b-a1f2-9455a984a1af	true	introspection.token.claim
933bcc2c-7bda-4f6b-a1f2-9455a984a1af	true	userinfo.token.claim
933bcc2c-7bda-4f6b-a1f2-9455a984a1af	emailVerified	user.attribute
933bcc2c-7bda-4f6b-a1f2-9455a984a1af	true	id.token.claim
933bcc2c-7bda-4f6b-a1f2-9455a984a1af	true	access.token.claim
933bcc2c-7bda-4f6b-a1f2-9455a984a1af	email_verified	claim.name
933bcc2c-7bda-4f6b-a1f2-9455a984a1af	boolean	jsonType.label
af1c910c-73e3-4986-b6e2-5e26b5cebb76	true	introspection.token.claim
af1c910c-73e3-4986-b6e2-5e26b5cebb76	true	userinfo.token.claim
af1c910c-73e3-4986-b6e2-5e26b5cebb76	email	user.attribute
af1c910c-73e3-4986-b6e2-5e26b5cebb76	true	id.token.claim
af1c910c-73e3-4986-b6e2-5e26b5cebb76	true	access.token.claim
af1c910c-73e3-4986-b6e2-5e26b5cebb76	email	claim.name
af1c910c-73e3-4986-b6e2-5e26b5cebb76	String	jsonType.label
fff2dab6-1656-45a1-a0cf-d51fe1cb0c9b	formatted	user.attribute.formatted
fff2dab6-1656-45a1-a0cf-d51fe1cb0c9b	country	user.attribute.country
fff2dab6-1656-45a1-a0cf-d51fe1cb0c9b	true	introspection.token.claim
fff2dab6-1656-45a1-a0cf-d51fe1cb0c9b	postal_code	user.attribute.postal_code
fff2dab6-1656-45a1-a0cf-d51fe1cb0c9b	true	userinfo.token.claim
fff2dab6-1656-45a1-a0cf-d51fe1cb0c9b	street	user.attribute.street
fff2dab6-1656-45a1-a0cf-d51fe1cb0c9b	true	id.token.claim
fff2dab6-1656-45a1-a0cf-d51fe1cb0c9b	region	user.attribute.region
fff2dab6-1656-45a1-a0cf-d51fe1cb0c9b	true	access.token.claim
fff2dab6-1656-45a1-a0cf-d51fe1cb0c9b	locality	user.attribute.locality
8bef54c9-85e9-42c4-a27f-4f140fcac8f1	true	introspection.token.claim
8bef54c9-85e9-42c4-a27f-4f140fcac8f1	true	userinfo.token.claim
8bef54c9-85e9-42c4-a27f-4f140fcac8f1	phoneNumberVerified	user.attribute
8bef54c9-85e9-42c4-a27f-4f140fcac8f1	true	id.token.claim
8bef54c9-85e9-42c4-a27f-4f140fcac8f1	true	access.token.claim
8bef54c9-85e9-42c4-a27f-4f140fcac8f1	phone_number_verified	claim.name
8bef54c9-85e9-42c4-a27f-4f140fcac8f1	boolean	jsonType.label
a37cec13-fa4b-4cc5-9f63-196ea3a41c92	true	introspection.token.claim
a37cec13-fa4b-4cc5-9f63-196ea3a41c92	true	userinfo.token.claim
a37cec13-fa4b-4cc5-9f63-196ea3a41c92	phoneNumber	user.attribute
a37cec13-fa4b-4cc5-9f63-196ea3a41c92	true	id.token.claim
a37cec13-fa4b-4cc5-9f63-196ea3a41c92	true	access.token.claim
a37cec13-fa4b-4cc5-9f63-196ea3a41c92	phone_number	claim.name
a37cec13-fa4b-4cc5-9f63-196ea3a41c92	String	jsonType.label
29adf596-d51b-48de-8747-9520f5a2319c	true	introspection.token.claim
29adf596-d51b-48de-8747-9520f5a2319c	true	access.token.claim
a706e669-4f37-4264-b04f-ae87aa094e5c	true	introspection.token.claim
a706e669-4f37-4264-b04f-ae87aa094e5c	true	multivalued
a706e669-4f37-4264-b04f-ae87aa094e5c	foo	user.attribute
a706e669-4f37-4264-b04f-ae87aa094e5c	true	access.token.claim
a706e669-4f37-4264-b04f-ae87aa094e5c	realm_access.roles	claim.name
a706e669-4f37-4264-b04f-ae87aa094e5c	String	jsonType.label
b34f7f51-4c07-4b9b-a9b8-8c2d61878b24	true	introspection.token.claim
b34f7f51-4c07-4b9b-a9b8-8c2d61878b24	true	multivalued
b34f7f51-4c07-4b9b-a9b8-8c2d61878b24	foo	user.attribute
b34f7f51-4c07-4b9b-a9b8-8c2d61878b24	true	access.token.claim
b34f7f51-4c07-4b9b-a9b8-8c2d61878b24	resource_access.${client_id}.roles	claim.name
b34f7f51-4c07-4b9b-a9b8-8c2d61878b24	String	jsonType.label
05a07e3d-7b37-494e-b6ab-dc1fd9e53db4	true	introspection.token.claim
05a07e3d-7b37-494e-b6ab-dc1fd9e53db4	true	access.token.claim
2d1482bc-f84e-45c3-abab-def27d7ce036	true	introspection.token.claim
2d1482bc-f84e-45c3-abab-def27d7ce036	true	userinfo.token.claim
2d1482bc-f84e-45c3-abab-def27d7ce036	username	user.attribute
2d1482bc-f84e-45c3-abab-def27d7ce036	true	id.token.claim
2d1482bc-f84e-45c3-abab-def27d7ce036	true	access.token.claim
2d1482bc-f84e-45c3-abab-def27d7ce036	upn	claim.name
2d1482bc-f84e-45c3-abab-def27d7ce036	String	jsonType.label
8c7a3980-148a-4328-a4e4-85d11893e7ab	true	introspection.token.claim
8c7a3980-148a-4328-a4e4-85d11893e7ab	true	multivalued
8c7a3980-148a-4328-a4e4-85d11893e7ab	foo	user.attribute
8c7a3980-148a-4328-a4e4-85d11893e7ab	true	id.token.claim
8c7a3980-148a-4328-a4e4-85d11893e7ab	true	access.token.claim
8c7a3980-148a-4328-a4e4-85d11893e7ab	groups	claim.name
8c7a3980-148a-4328-a4e4-85d11893e7ab	String	jsonType.label
8a3a45cb-9a1b-437f-a062-cade24404a71	true	introspection.token.claim
8a3a45cb-9a1b-437f-a062-cade24404a71	true	id.token.claim
8a3a45cb-9a1b-437f-a062-cade24404a71	true	access.token.claim
7a5fd19c-dfa7-4a5d-af81-dab737b47994	true	introspection.token.claim
7a5fd19c-dfa7-4a5d-af81-dab737b47994	true	access.token.claim
d2e7ba76-0c83-41e8-97c9-a63af28314fc	AUTH_TIME	user.session.note
d2e7ba76-0c83-41e8-97c9-a63af28314fc	true	introspection.token.claim
d2e7ba76-0c83-41e8-97c9-a63af28314fc	true	id.token.claim
d2e7ba76-0c83-41e8-97c9-a63af28314fc	true	access.token.claim
d2e7ba76-0c83-41e8-97c9-a63af28314fc	auth_time	claim.name
d2e7ba76-0c83-41e8-97c9-a63af28314fc	long	jsonType.label
3b6a0297-85af-4ae0-9fd0-3e85b1d89c08	true	introspection.token.claim
3b6a0297-85af-4ae0-9fd0-3e85b1d89c08	true	access.token.claim
8c2582ba-4e8f-4b39-a116-ca954535a770	foo	user.attribute
8c2582ba-4e8f-4b39-a116-ca954535a770	true	introspection.token.claim
8c2582ba-4e8f-4b39-a116-ca954535a770	true	access.token.claim
8c2582ba-4e8f-4b39-a116-ca954535a770	resource_access.${client_id}.roles	claim.name
8c2582ba-4e8f-4b39-a116-ca954535a770	String	jsonType.label
8c2582ba-4e8f-4b39-a116-ca954535a770	true	multivalued
94418ad3-3c32-4d2d-a093-562f8b36ee10	foo	user.attribute
94418ad3-3c32-4d2d-a093-562f8b36ee10	true	introspection.token.claim
94418ad3-3c32-4d2d-a093-562f8b36ee10	true	access.token.claim
94418ad3-3c32-4d2d-a093-562f8b36ee10	realm_access.roles	claim.name
94418ad3-3c32-4d2d-a093-562f8b36ee10	String	jsonType.label
94418ad3-3c32-4d2d-a093-562f8b36ee10	true	multivalued
5dbf54bf-f5b9-4361-9669-6796a515ef33	AUTH_TIME	user.session.note
5dbf54bf-f5b9-4361-9669-6796a515ef33	true	introspection.token.claim
5dbf54bf-f5b9-4361-9669-6796a515ef33	true	userinfo.token.claim
5dbf54bf-f5b9-4361-9669-6796a515ef33	true	id.token.claim
5dbf54bf-f5b9-4361-9669-6796a515ef33	true	access.token.claim
5dbf54bf-f5b9-4361-9669-6796a515ef33	auth_time	claim.name
5dbf54bf-f5b9-4361-9669-6796a515ef33	long	jsonType.label
9cea473c-40fc-4561-8615-8275570e67a8	true	introspection.token.claim
9cea473c-40fc-4561-8615-8275570e67a8	true	access.token.claim
79994c8b-ee3f-42dc-9c7b-362ae2674b33	true	introspection.token.claim
79994c8b-ee3f-42dc-9c7b-362ae2674b33	true	userinfo.token.claim
79994c8b-ee3f-42dc-9c7b-362ae2674b33	phoneNumberVerified	user.attribute
79994c8b-ee3f-42dc-9c7b-362ae2674b33	true	id.token.claim
79994c8b-ee3f-42dc-9c7b-362ae2674b33	true	access.token.claim
79994c8b-ee3f-42dc-9c7b-362ae2674b33	phone_number_verified	claim.name
79994c8b-ee3f-42dc-9c7b-362ae2674b33	boolean	jsonType.label
f49325a5-e360-4700-a7d0-727af85c6f5a	true	introspection.token.claim
f49325a5-e360-4700-a7d0-727af85c6f5a	true	userinfo.token.claim
f49325a5-e360-4700-a7d0-727af85c6f5a	phoneNumber	user.attribute
f49325a5-e360-4700-a7d0-727af85c6f5a	true	id.token.claim
f49325a5-e360-4700-a7d0-727af85c6f5a	true	access.token.claim
f49325a5-e360-4700-a7d0-727af85c6f5a	phone_number	claim.name
f49325a5-e360-4700-a7d0-727af85c6f5a	String	jsonType.label
4a8f4c7c-56ec-476b-9d13-1e9f3454c6fb	true	introspection.token.claim
4a8f4c7c-56ec-476b-9d13-1e9f3454c6fb	true	multivalued
4a8f4c7c-56ec-476b-9d13-1e9f3454c6fb	true	userinfo.token.claim
4a8f4c7c-56ec-476b-9d13-1e9f3454c6fb	foo	user.attribute
4a8f4c7c-56ec-476b-9d13-1e9f3454c6fb	true	id.token.claim
4a8f4c7c-56ec-476b-9d13-1e9f3454c6fb	true	access.token.claim
4a8f4c7c-56ec-476b-9d13-1e9f3454c6fb	groups	claim.name
4a8f4c7c-56ec-476b-9d13-1e9f3454c6fb	String	jsonType.label
6c363dd0-1aaf-4689-9749-3e0d3c02b963	true	introspection.token.claim
6c363dd0-1aaf-4689-9749-3e0d3c02b963	true	userinfo.token.claim
6c363dd0-1aaf-4689-9749-3e0d3c02b963	username	user.attribute
6c363dd0-1aaf-4689-9749-3e0d3c02b963	true	id.token.claim
6c363dd0-1aaf-4689-9749-3e0d3c02b963	true	access.token.claim
6c363dd0-1aaf-4689-9749-3e0d3c02b963	upn	claim.name
6c363dd0-1aaf-4689-9749-3e0d3c02b963	String	jsonType.label
5947e4bb-c81e-4549-b426-3eac584b9e87	true	introspection.token.claim
5947e4bb-c81e-4549-b426-3eac584b9e87	true	access.token.claim
31da9e7a-2ffd-41a2-a381-26172028de2e	true	id.token.claim
31da9e7a-2ffd-41a2-a381-26172028de2e	true	introspection.token.claim
31da9e7a-2ffd-41a2-a381-26172028de2e	true	access.token.claim
31da9e7a-2ffd-41a2-a381-26172028de2e	true	userinfo.token.claim
f471b384-3ef9-493f-8d93-027fd503c11a	false	single
f471b384-3ef9-493f-8d93-027fd503c11a	Basic	attribute.nameformat
f471b384-3ef9-493f-8d93-027fd503c11a	Role	attribute.name
0d177c32-c17d-43c5-a783-f5f23fa73ec9	true	introspection.token.claim
0d177c32-c17d-43c5-a783-f5f23fa73ec9	true	userinfo.token.claim
0d177c32-c17d-43c5-a783-f5f23fa73ec9	picture	user.attribute
0d177c32-c17d-43c5-a783-f5f23fa73ec9	true	id.token.claim
0d177c32-c17d-43c5-a783-f5f23fa73ec9	true	access.token.claim
0d177c32-c17d-43c5-a783-f5f23fa73ec9	picture	claim.name
0d177c32-c17d-43c5-a783-f5f23fa73ec9	String	jsonType.label
33de2a4b-846c-4781-ae98-b5e135933bcf	true	id.token.claim
33de2a4b-846c-4781-ae98-b5e135933bcf	true	introspection.token.claim
33de2a4b-846c-4781-ae98-b5e135933bcf	true	access.token.claim
33de2a4b-846c-4781-ae98-b5e135933bcf	true	userinfo.token.claim
4587fee8-e1cc-45eb-b047-6b5c56968cf1	true	introspection.token.claim
4587fee8-e1cc-45eb-b047-6b5c56968cf1	true	userinfo.token.claim
4587fee8-e1cc-45eb-b047-6b5c56968cf1	nickname	user.attribute
4587fee8-e1cc-45eb-b047-6b5c56968cf1	true	id.token.claim
4587fee8-e1cc-45eb-b047-6b5c56968cf1	true	access.token.claim
4587fee8-e1cc-45eb-b047-6b5c56968cf1	nickname	claim.name
4587fee8-e1cc-45eb-b047-6b5c56968cf1	String	jsonType.label
575eef97-85f0-42d0-a784-dd9f45639c7b	true	introspection.token.claim
575eef97-85f0-42d0-a784-dd9f45639c7b	true	userinfo.token.claim
575eef97-85f0-42d0-a784-dd9f45639c7b	zoneinfo	user.attribute
575eef97-85f0-42d0-a784-dd9f45639c7b	true	id.token.claim
575eef97-85f0-42d0-a784-dd9f45639c7b	true	access.token.claim
575eef97-85f0-42d0-a784-dd9f45639c7b	zoneinfo	claim.name
575eef97-85f0-42d0-a784-dd9f45639c7b	String	jsonType.label
634dc2f4-37f6-4ed9-9701-706993560c27	true	introspection.token.claim
634dc2f4-37f6-4ed9-9701-706993560c27	true	userinfo.token.claim
634dc2f4-37f6-4ed9-9701-706993560c27	profile	user.attribute
634dc2f4-37f6-4ed9-9701-706993560c27	true	id.token.claim
634dc2f4-37f6-4ed9-9701-706993560c27	true	access.token.claim
634dc2f4-37f6-4ed9-9701-706993560c27	profile	claim.name
634dc2f4-37f6-4ed9-9701-706993560c27	String	jsonType.label
6444950b-4184-433a-9173-3830b43a7c60	true	introspection.token.claim
6444950b-4184-433a-9173-3830b43a7c60	true	userinfo.token.claim
6444950b-4184-433a-9173-3830b43a7c60	firstName	user.attribute
6444950b-4184-433a-9173-3830b43a7c60	true	id.token.claim
6444950b-4184-433a-9173-3830b43a7c60	true	access.token.claim
6444950b-4184-433a-9173-3830b43a7c60	given_name	claim.name
6444950b-4184-433a-9173-3830b43a7c60	String	jsonType.label
66fd2062-1f53-4153-9919-9051e637dd3a	true	introspection.token.claim
66fd2062-1f53-4153-9919-9051e637dd3a	true	userinfo.token.claim
66fd2062-1f53-4153-9919-9051e637dd3a	website	user.attribute
66fd2062-1f53-4153-9919-9051e637dd3a	true	id.token.claim
66fd2062-1f53-4153-9919-9051e637dd3a	true	access.token.claim
66fd2062-1f53-4153-9919-9051e637dd3a	website	claim.name
66fd2062-1f53-4153-9919-9051e637dd3a	String	jsonType.label
6fd19163-2fc3-4afc-9dfb-2afbc2e73fdb	true	introspection.token.claim
6fd19163-2fc3-4afc-9dfb-2afbc2e73fdb	true	userinfo.token.claim
6fd19163-2fc3-4afc-9dfb-2afbc2e73fdb	updatedAt	user.attribute
6fd19163-2fc3-4afc-9dfb-2afbc2e73fdb	true	id.token.claim
6fd19163-2fc3-4afc-9dfb-2afbc2e73fdb	true	access.token.claim
6fd19163-2fc3-4afc-9dfb-2afbc2e73fdb	updated_at	claim.name
6fd19163-2fc3-4afc-9dfb-2afbc2e73fdb	long	jsonType.label
70fedac6-9ade-4c0b-ba25-fe8c70fbc1d2	true	introspection.token.claim
70fedac6-9ade-4c0b-ba25-fe8c70fbc1d2	true	userinfo.token.claim
70fedac6-9ade-4c0b-ba25-fe8c70fbc1d2	gender	user.attribute
70fedac6-9ade-4c0b-ba25-fe8c70fbc1d2	true	id.token.claim
70fedac6-9ade-4c0b-ba25-fe8c70fbc1d2	true	access.token.claim
70fedac6-9ade-4c0b-ba25-fe8c70fbc1d2	gender	claim.name
70fedac6-9ade-4c0b-ba25-fe8c70fbc1d2	String	jsonType.label
8376de16-8509-4102-b513-b10bba874454	true	introspection.token.claim
8376de16-8509-4102-b513-b10bba874454	true	userinfo.token.claim
8376de16-8509-4102-b513-b10bba874454	locale	user.attribute
8376de16-8509-4102-b513-b10bba874454	true	id.token.claim
8376de16-8509-4102-b513-b10bba874454	true	access.token.claim
8376de16-8509-4102-b513-b10bba874454	locale	claim.name
8376de16-8509-4102-b513-b10bba874454	String	jsonType.label
ac813ab0-5936-46ef-a8ba-59bc862f1915	true	introspection.token.claim
ac813ab0-5936-46ef-a8ba-59bc862f1915	true	userinfo.token.claim
ac813ab0-5936-46ef-a8ba-59bc862f1915	lastName	user.attribute
ac813ab0-5936-46ef-a8ba-59bc862f1915	true	id.token.claim
ac813ab0-5936-46ef-a8ba-59bc862f1915	true	access.token.claim
ac813ab0-5936-46ef-a8ba-59bc862f1915	family_name	claim.name
ac813ab0-5936-46ef-a8ba-59bc862f1915	String	jsonType.label
b3abaad5-b7c5-49cd-8769-3a8579e7a68f	true	introspection.token.claim
b3abaad5-b7c5-49cd-8769-3a8579e7a68f	true	userinfo.token.claim
b3abaad5-b7c5-49cd-8769-3a8579e7a68f	middleName	user.attribute
b3abaad5-b7c5-49cd-8769-3a8579e7a68f	true	id.token.claim
b3abaad5-b7c5-49cd-8769-3a8579e7a68f	true	access.token.claim
b3abaad5-b7c5-49cd-8769-3a8579e7a68f	middle_name	claim.name
b3abaad5-b7c5-49cd-8769-3a8579e7a68f	String	jsonType.label
b5ab6fa5-dc61-4fd7-88e3-af054814ae3b	true	introspection.token.claim
b5ab6fa5-dc61-4fd7-88e3-af054814ae3b	true	userinfo.token.claim
b5ab6fa5-dc61-4fd7-88e3-af054814ae3b	username	user.attribute
b5ab6fa5-dc61-4fd7-88e3-af054814ae3b	true	id.token.claim
b5ab6fa5-dc61-4fd7-88e3-af054814ae3b	true	access.token.claim
b5ab6fa5-dc61-4fd7-88e3-af054814ae3b	preferred_username	claim.name
b5ab6fa5-dc61-4fd7-88e3-af054814ae3b	String	jsonType.label
bf7d2af2-7ff2-440c-9c5e-968bc3b14694	true	introspection.token.claim
bf7d2af2-7ff2-440c-9c5e-968bc3b14694	true	userinfo.token.claim
bf7d2af2-7ff2-440c-9c5e-968bc3b14694	birthdate	user.attribute
bf7d2af2-7ff2-440c-9c5e-968bc3b14694	true	id.token.claim
bf7d2af2-7ff2-440c-9c5e-968bc3b14694	true	access.token.claim
bf7d2af2-7ff2-440c-9c5e-968bc3b14694	birthdate	claim.name
bf7d2af2-7ff2-440c-9c5e-968bc3b14694	String	jsonType.label
2d8994c5-fd03-4008-bf59-68ba7191c95c	true	introspection.token.claim
2d8994c5-fd03-4008-bf59-68ba7191c95c	true	userinfo.token.claim
2d8994c5-fd03-4008-bf59-68ba7191c95c	email	user.attribute
2d8994c5-fd03-4008-bf59-68ba7191c95c	true	id.token.claim
2d8994c5-fd03-4008-bf59-68ba7191c95c	true	access.token.claim
2d8994c5-fd03-4008-bf59-68ba7191c95c	email	claim.name
2d8994c5-fd03-4008-bf59-68ba7191c95c	String	jsonType.label
aba18f62-c3dc-45f5-aaab-e7426708c408	true	introspection.token.claim
aba18f62-c3dc-45f5-aaab-e7426708c408	true	userinfo.token.claim
aba18f62-c3dc-45f5-aaab-e7426708c408	emailVerified	user.attribute
aba18f62-c3dc-45f5-aaab-e7426708c408	true	id.token.claim
aba18f62-c3dc-45f5-aaab-e7426708c408	true	access.token.claim
aba18f62-c3dc-45f5-aaab-e7426708c408	email_verified	claim.name
aba18f62-c3dc-45f5-aaab-e7426708c408	boolean	jsonType.label
142c9dc8-6910-46a5-ab0f-d05b06dab26c	formatted	user.attribute.formatted
142c9dc8-6910-46a5-ab0f-d05b06dab26c	country	user.attribute.country
142c9dc8-6910-46a5-ab0f-d05b06dab26c	true	introspection.token.claim
142c9dc8-6910-46a5-ab0f-d05b06dab26c	postal_code	user.attribute.postal_code
142c9dc8-6910-46a5-ab0f-d05b06dab26c	true	userinfo.token.claim
142c9dc8-6910-46a5-ab0f-d05b06dab26c	street	user.attribute.street
142c9dc8-6910-46a5-ab0f-d05b06dab26c	true	id.token.claim
142c9dc8-6910-46a5-ab0f-d05b06dab26c	region	user.attribute.region
142c9dc8-6910-46a5-ab0f-d05b06dab26c	true	access.token.claim
142c9dc8-6910-46a5-ab0f-d05b06dab26c	locality	user.attribute.locality
0e4cb6e0-4d4a-434e-9586-edb8ca7e3a89	clientHost	user.session.note
0e4cb6e0-4d4a-434e-9586-edb8ca7e3a89	true	introspection.token.claim
0e4cb6e0-4d4a-434e-9586-edb8ca7e3a89	true	userinfo.token.claim
0e4cb6e0-4d4a-434e-9586-edb8ca7e3a89	true	id.token.claim
0e4cb6e0-4d4a-434e-9586-edb8ca7e3a89	true	access.token.claim
0e4cb6e0-4d4a-434e-9586-edb8ca7e3a89	clientHost	claim.name
0e4cb6e0-4d4a-434e-9586-edb8ca7e3a89	String	jsonType.label
8c2eb44f-444d-4fe6-bbf8-1598a7d91028	client_id	user.session.note
8c2eb44f-444d-4fe6-bbf8-1598a7d91028	true	introspection.token.claim
8c2eb44f-444d-4fe6-bbf8-1598a7d91028	true	userinfo.token.claim
8c2eb44f-444d-4fe6-bbf8-1598a7d91028	true	id.token.claim
8c2eb44f-444d-4fe6-bbf8-1598a7d91028	true	access.token.claim
8c2eb44f-444d-4fe6-bbf8-1598a7d91028	client_id	claim.name
8c2eb44f-444d-4fe6-bbf8-1598a7d91028	String	jsonType.label
dd8d163c-4e92-4434-8d1f-9966f3ac6ab0	clientAddress	user.session.note
dd8d163c-4e92-4434-8d1f-9966f3ac6ab0	true	introspection.token.claim
dd8d163c-4e92-4434-8d1f-9966f3ac6ab0	true	userinfo.token.claim
dd8d163c-4e92-4434-8d1f-9966f3ac6ab0	true	id.token.claim
dd8d163c-4e92-4434-8d1f-9966f3ac6ab0	true	access.token.claim
dd8d163c-4e92-4434-8d1f-9966f3ac6ab0	clientAddress	claim.name
dd8d163c-4e92-4434-8d1f-9966f3ac6ab0	String	jsonType.label
78fba238-bf0d-4c0b-9788-04bdec87434d	true	introspection.token.claim
78fba238-bf0d-4c0b-9788-04bdec87434d	true	userinfo.token.claim
78fba238-bf0d-4c0b-9788-04bdec87434d	locale	user.attribute
78fba238-bf0d-4c0b-9788-04bdec87434d	true	id.token.claim
78fba238-bf0d-4c0b-9788-04bdec87434d	true	access.token.claim
78fba238-bf0d-4c0b-9788-04bdec87434d	locale	claim.name
78fba238-bf0d-4c0b-9788-04bdec87434d	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
1188f655-9676-4630-ba0e-451e8cbc5697	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	433248d8-6ac7-475a-a9cd-6a7977a2c034	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	171e9df6-a7b8-46c9-bc61-6520359f744a	9f77e263-b0d7-49ba-b0ac-ee76e8f5a58e	ee3b6286-0e37-47e4-8895-88ea7667fb1d	46f35fd4-e8d7-4c11-8e38-eb72b7a17e14	75daa8f0-22ef-4466-8d59-9a58ee74c1fb	2592000	f	900	t	f	5bf24d8f-6937-4804-b6ae-761230fe0c70	0	f	0	0	2a87b4a0-a156-49d5-9edc-9e8e0e53b699
0ff635a9-4a9c-47af-8eec-860d88e871e8	60	300	300	\N	\N	\N	t	f	0	\N	TestCompanyRealm	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	0268cef5-ed1c-4f38-8eb1-675068670e01	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	e4b7aebc-54f8-4a49-8aea-58605e34d8c8	b89a445f-102f-42e9-9c16-b1c37f746b91	8c209791-2d9c-4250-9c20-fccacd3e56cb	63e93642-eee9-45d4-a862-852306f6d678	40ca7d73-264f-4031-89be-3a610dfab4d4	2592000	f	900	t	f	f5b6a48a-a1c6-4b30-879c-e2be53b4b78e	0	f	0	0	3bfad9c8-a75c-418f-9217-ccb6871e7421
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	1188f655-9676-4630-ba0e-451e8cbc5697	
_browser_header.xContentTypeOptions	1188f655-9676-4630-ba0e-451e8cbc5697	nosniff
_browser_header.referrerPolicy	1188f655-9676-4630-ba0e-451e8cbc5697	no-referrer
_browser_header.xRobotsTag	1188f655-9676-4630-ba0e-451e8cbc5697	none
_browser_header.xFrameOptions	1188f655-9676-4630-ba0e-451e8cbc5697	SAMEORIGIN
_browser_header.contentSecurityPolicy	1188f655-9676-4630-ba0e-451e8cbc5697	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	1188f655-9676-4630-ba0e-451e8cbc5697	1; mode=block
_browser_header.strictTransportSecurity	1188f655-9676-4630-ba0e-451e8cbc5697	max-age=31536000; includeSubDomains
bruteForceProtected	1188f655-9676-4630-ba0e-451e8cbc5697	false
permanentLockout	1188f655-9676-4630-ba0e-451e8cbc5697	false
maxTemporaryLockouts	1188f655-9676-4630-ba0e-451e8cbc5697	0
maxFailureWaitSeconds	1188f655-9676-4630-ba0e-451e8cbc5697	900
minimumQuickLoginWaitSeconds	1188f655-9676-4630-ba0e-451e8cbc5697	60
waitIncrementSeconds	1188f655-9676-4630-ba0e-451e8cbc5697	60
quickLoginCheckMilliSeconds	1188f655-9676-4630-ba0e-451e8cbc5697	1000
maxDeltaTimeSeconds	1188f655-9676-4630-ba0e-451e8cbc5697	43200
failureFactor	1188f655-9676-4630-ba0e-451e8cbc5697	30
realmReusableOtpCode	1188f655-9676-4630-ba0e-451e8cbc5697	false
firstBrokerLoginFlowId	1188f655-9676-4630-ba0e-451e8cbc5697	3c6f183c-6045-4676-9212-05c783706d1c
displayName	1188f655-9676-4630-ba0e-451e8cbc5697	Keycloak
displayNameHtml	1188f655-9676-4630-ba0e-451e8cbc5697	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	1188f655-9676-4630-ba0e-451e8cbc5697	RS256
offlineSessionMaxLifespanEnabled	1188f655-9676-4630-ba0e-451e8cbc5697	false
offlineSessionMaxLifespan	1188f655-9676-4630-ba0e-451e8cbc5697	5184000
_browser_header.contentSecurityPolicyReportOnly	0ff635a9-4a9c-47af-8eec-860d88e871e8	
_browser_header.xContentTypeOptions	0ff635a9-4a9c-47af-8eec-860d88e871e8	nosniff
_browser_header.referrerPolicy	0ff635a9-4a9c-47af-8eec-860d88e871e8	no-referrer
_browser_header.xRobotsTag	0ff635a9-4a9c-47af-8eec-860d88e871e8	none
_browser_header.xFrameOptions	0ff635a9-4a9c-47af-8eec-860d88e871e8	SAMEORIGIN
_browser_header.contentSecurityPolicy	0ff635a9-4a9c-47af-8eec-860d88e871e8	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	0ff635a9-4a9c-47af-8eec-860d88e871e8	1; mode=block
_browser_header.strictTransportSecurity	0ff635a9-4a9c-47af-8eec-860d88e871e8	max-age=31536000; includeSubDomains
bruteForceProtected	0ff635a9-4a9c-47af-8eec-860d88e871e8	false
permanentLockout	0ff635a9-4a9c-47af-8eec-860d88e871e8	false
maxTemporaryLockouts	0ff635a9-4a9c-47af-8eec-860d88e871e8	0
maxFailureWaitSeconds	0ff635a9-4a9c-47af-8eec-860d88e871e8	900
minimumQuickLoginWaitSeconds	0ff635a9-4a9c-47af-8eec-860d88e871e8	60
waitIncrementSeconds	0ff635a9-4a9c-47af-8eec-860d88e871e8	60
quickLoginCheckMilliSeconds	0ff635a9-4a9c-47af-8eec-860d88e871e8	1000
maxDeltaTimeSeconds	0ff635a9-4a9c-47af-8eec-860d88e871e8	43200
failureFactor	0ff635a9-4a9c-47af-8eec-860d88e871e8	30
realmReusableOtpCode	0ff635a9-4a9c-47af-8eec-860d88e871e8	false
defaultSignatureAlgorithm	0ff635a9-4a9c-47af-8eec-860d88e871e8	RS256
offlineSessionMaxLifespanEnabled	0ff635a9-4a9c-47af-8eec-860d88e871e8	false
offlineSessionMaxLifespan	0ff635a9-4a9c-47af-8eec-860d88e871e8	5184000
clientSessionIdleTimeout	0ff635a9-4a9c-47af-8eec-860d88e871e8	0
clientSessionMaxLifespan	0ff635a9-4a9c-47af-8eec-860d88e871e8	0
clientOfflineSessionIdleTimeout	0ff635a9-4a9c-47af-8eec-860d88e871e8	0
clientOfflineSessionMaxLifespan	0ff635a9-4a9c-47af-8eec-860d88e871e8	0
actionTokenGeneratedByAdminLifespan	0ff635a9-4a9c-47af-8eec-860d88e871e8	43200
actionTokenGeneratedByUserLifespan	0ff635a9-4a9c-47af-8eec-860d88e871e8	300
oauth2DeviceCodeLifespan	0ff635a9-4a9c-47af-8eec-860d88e871e8	600
oauth2DevicePollingInterval	0ff635a9-4a9c-47af-8eec-860d88e871e8	5
organizationsEnabled	0ff635a9-4a9c-47af-8eec-860d88e871e8	false
webAuthnPolicyRpEntityName	0ff635a9-4a9c-47af-8eec-860d88e871e8	keycloak
webAuthnPolicySignatureAlgorithms	0ff635a9-4a9c-47af-8eec-860d88e871e8	ES256
webAuthnPolicyRpId	0ff635a9-4a9c-47af-8eec-860d88e871e8	
webAuthnPolicyAttestationConveyancePreference	0ff635a9-4a9c-47af-8eec-860d88e871e8	not specified
webAuthnPolicyAuthenticatorAttachment	0ff635a9-4a9c-47af-8eec-860d88e871e8	not specified
webAuthnPolicyRequireResidentKey	0ff635a9-4a9c-47af-8eec-860d88e871e8	not specified
webAuthnPolicyUserVerificationRequirement	0ff635a9-4a9c-47af-8eec-860d88e871e8	not specified
webAuthnPolicyCreateTimeout	0ff635a9-4a9c-47af-8eec-860d88e871e8	0
webAuthnPolicyAvoidSameAuthenticatorRegister	0ff635a9-4a9c-47af-8eec-860d88e871e8	false
webAuthnPolicyRpEntityNamePasswordless	0ff635a9-4a9c-47af-8eec-860d88e871e8	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	0ff635a9-4a9c-47af-8eec-860d88e871e8	ES256
webAuthnPolicyRpIdPasswordless	0ff635a9-4a9c-47af-8eec-860d88e871e8	
webAuthnPolicyAttestationConveyancePreferencePasswordless	0ff635a9-4a9c-47af-8eec-860d88e871e8	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	0ff635a9-4a9c-47af-8eec-860d88e871e8	not specified
webAuthnPolicyRequireResidentKeyPasswordless	0ff635a9-4a9c-47af-8eec-860d88e871e8	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	0ff635a9-4a9c-47af-8eec-860d88e871e8	not specified
webAuthnPolicyCreateTimeoutPasswordless	0ff635a9-4a9c-47af-8eec-860d88e871e8	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	0ff635a9-4a9c-47af-8eec-860d88e871e8	false
cibaBackchannelTokenDeliveryMode	0ff635a9-4a9c-47af-8eec-860d88e871e8	poll
cibaExpiresIn	0ff635a9-4a9c-47af-8eec-860d88e871e8	120
cibaInterval	0ff635a9-4a9c-47af-8eec-860d88e871e8	5
cibaAuthRequestedUserHint	0ff635a9-4a9c-47af-8eec-860d88e871e8	login_hint
parRequestUriLifespan	0ff635a9-4a9c-47af-8eec-860d88e871e8	60
firstBrokerLoginFlowId	0ff635a9-4a9c-47af-8eec-860d88e871e8	66390e1e-f83e-489a-84e3-790d4a27433f
client-policies.profiles	0ff635a9-4a9c-47af-8eec-860d88e871e8	{"profiles":[]}
client-policies.policies	0ff635a9-4a9c-47af-8eec-860d88e871e8	{"policies":[]}
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
1188f655-9676-4630-ba0e-451e8cbc5697	jboss-logging
0ff635a9-4a9c-47af-8eec-860d88e871e8	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	1188f655-9676-4630-ba0e-451e8cbc5697
password	password	t	t	0ff635a9-4a9c-47af-8eec-860d88e871e8
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
248766fb-d320-4a79-8a16-6567674baffd	/realms/master/account/*
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	/realms/master/account/*
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	/admin/master/console/*
91089183-fce3-4047-a65d-ee0d02228343	/realms/TestCompanyRealm/account/*
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	/realms/TestCompanyRealm/account/*
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	/*
61ae9827-8300-4046-a78b-6fc1df466f66	/admin/TestCompanyRealm/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
f04da435-5a2c-46da-a689-56687355ae9b	VERIFY_EMAIL	Verify Email	1188f655-9676-4630-ba0e-451e8cbc5697	t	f	VERIFY_EMAIL	50
ac00b527-d65e-4bec-a5a7-08ee57f136ab	UPDATE_PROFILE	Update Profile	1188f655-9676-4630-ba0e-451e8cbc5697	t	f	UPDATE_PROFILE	40
340b6c40-4fef-40bc-b96a-7e9232ba0285	CONFIGURE_TOTP	Configure OTP	1188f655-9676-4630-ba0e-451e8cbc5697	t	f	CONFIGURE_TOTP	10
0dafddc6-43d2-4114-a5b2-a078c4cba2d5	UPDATE_PASSWORD	Update Password	1188f655-9676-4630-ba0e-451e8cbc5697	t	f	UPDATE_PASSWORD	30
bfcae9d1-ec31-4ae7-87b7-1cf23bb23945	TERMS_AND_CONDITIONS	Terms and Conditions	1188f655-9676-4630-ba0e-451e8cbc5697	f	f	TERMS_AND_CONDITIONS	20
0028dba1-1722-4494-b66e-be1cec6bce5d	delete_account	Delete Account	1188f655-9676-4630-ba0e-451e8cbc5697	f	f	delete_account	60
22d0c832-659b-49d6-80c8-3c258d2ad27a	delete_credential	Delete Credential	1188f655-9676-4630-ba0e-451e8cbc5697	t	f	delete_credential	100
d0a7e877-4568-49cd-b310-fbc4af245ad3	update_user_locale	Update User Locale	1188f655-9676-4630-ba0e-451e8cbc5697	t	f	update_user_locale	1000
3dc7f9fa-5193-4092-bf25-20c6f7a62691	webauthn-register	Webauthn Register	1188f655-9676-4630-ba0e-451e8cbc5697	t	f	webauthn-register	70
a03d3ef2-679e-48c8-b448-8c846ee3fde2	webauthn-register-passwordless	Webauthn Register Passwordless	1188f655-9676-4630-ba0e-451e8cbc5697	t	f	webauthn-register-passwordless	80
640c1216-17bb-4c4e-a6f2-cfd8e093971a	VERIFY_PROFILE	Verify Profile	1188f655-9676-4630-ba0e-451e8cbc5697	t	f	VERIFY_PROFILE	90
39afca66-c198-4d0b-af02-338d902de395	CONFIGURE_TOTP	Configure OTP	0ff635a9-4a9c-47af-8eec-860d88e871e8	t	f	CONFIGURE_TOTP	10
43ff2fc7-a6e8-4d49-966c-8954c370d961	TERMS_AND_CONDITIONS	Terms and Conditions	0ff635a9-4a9c-47af-8eec-860d88e871e8	f	f	TERMS_AND_CONDITIONS	20
2f327bdf-1b3f-480b-a524-01a8b55af29c	UPDATE_PASSWORD	Update Password	0ff635a9-4a9c-47af-8eec-860d88e871e8	t	f	UPDATE_PASSWORD	30
b425255a-4cb2-4710-ad87-d1843e57ed4b	UPDATE_PROFILE	Update Profile	0ff635a9-4a9c-47af-8eec-860d88e871e8	t	f	UPDATE_PROFILE	40
efc88a9d-5761-4800-9927-25b7dfa734da	VERIFY_EMAIL	Verify Email	0ff635a9-4a9c-47af-8eec-860d88e871e8	t	f	VERIFY_EMAIL	50
d4090f69-70b0-4b44-9be4-31ac7939f94c	delete_account	Delete Account	0ff635a9-4a9c-47af-8eec-860d88e871e8	f	f	delete_account	60
808a17a8-9eb0-42ac-bb80-247e19970097	webauthn-register	Webauthn Register	0ff635a9-4a9c-47af-8eec-860d88e871e8	t	f	webauthn-register	70
7a53024d-cf8f-462e-8f03-ef06ace9d981	webauthn-register-passwordless	Webauthn Register Passwordless	0ff635a9-4a9c-47af-8eec-860d88e871e8	t	f	webauthn-register-passwordless	80
c3222b2f-389c-402a-88aa-038ce8195b37	delete_credential	Delete Credential	0ff635a9-4a9c-47af-8eec-860d88e871e8	t	f	delete_credential	100
060f0117-9591-494a-ad29-a422ea49b6c2	update_user_locale	Update User Locale	0ff635a9-4a9c-47af-8eec-860d88e871e8	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	9c621830-6ae4-45fc-a032-b7b093356a72
44f5bda9-56dc-4dfd-aafc-a29f383c30fd	9a31d2c7-8255-4959-8621-738a101e90f9
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	b673fe95-750b-4d27-94e4-86166d297405
3ee0e7fa-298f-43a8-8fd5-f108dcb6941b	fc307556-c8d5-4331-8267-197e96c749d2
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
a239665b-c652-4116-8610-9a2578b755ab	\N	a2d66bbe-e708-479f-8ad0-af370b5144d5	f	t	\N	\N	\N	0ff635a9-4a9c-47af-8eec-860d88e871e8	service-account-admin-cli	1730720693866	6368b30f-a0a7-4c96-bd53-7cea84ed0efe	0
5857c2dc-a96b-4b98-9ba9-f063fbe25248	\N	a9986c35-d629-4ed8-8139-77daf48e3ffd	f	t	\N	\N	\N	1188f655-9676-4630-ba0e-451e8cbc5697	admin	1730871196657	\N	0
6b4a7c02-4407-4290-8566-41dff1624c70	super_admin@example.com	super_admin@example.com	t	t	\N	super	admin	0ff635a9-4a9c-47af-8eec-860d88e871e8	super_admin	1730871691860	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
3bfad9c8-a75c-418f-9217-ccb6871e7421	a239665b-c652-4116-8610-9a2578b755ab
ca8c3a4c-16e0-48ce-87cd-baf026000313	a239665b-c652-4116-8610-9a2578b755ab
110c2e24-4286-4fa6-bba5-0b3535dc2a55	a239665b-c652-4116-8610-9a2578b755ab
71a4fd37-951a-4f0d-a00b-a6510b5152e4	a239665b-c652-4116-8610-9a2578b755ab
53499e96-a22d-473a-8dff-dbcf8f239fe8	a239665b-c652-4116-8610-9a2578b755ab
2a87b4a0-a156-49d5-9edc-9e8e0e53b699	5857c2dc-a96b-4b98-9ba9-f063fbe25248
8928adec-228a-4cd7-992f-0605f8ee9731	5857c2dc-a96b-4b98-9ba9-f063fbe25248
3bfad9c8-a75c-418f-9217-ccb6871e7421	6b4a7c02-4407-4290-8566-41dff1624c70
8952c2be-f5e1-42d5-8f6a-ac3d420a836a	6b4a7c02-4407-4290-8566-41dff1624c70
899b3a45-63fa-456b-9399-fdae157df40b	6b4a7c02-4407-4290-8566-41dff1624c70
9f7fa847-289e-4197-a296-38146a5d3c5f	6b4a7c02-4407-4290-8566-41dff1624c70
110c2e24-4286-4fa6-bba5-0b3535dc2a55	6b4a7c02-4407-4290-8566-41dff1624c70
188c431b-c4ac-4ecd-b784-278dd775b721	6b4a7c02-4407-4290-8566-41dff1624c70
71a4fd37-951a-4f0d-a00b-a6510b5152e4	6b4a7c02-4407-4290-8566-41dff1624c70
53499e96-a22d-473a-8dff-dbcf8f239fe8	6b4a7c02-4407-4290-8566-41dff1624c70
1af4bb97-d459-48e3-bc58-e3e7c3be873d	6b4a7c02-4407-4290-8566-41dff1624c70
fb6898ac-461a-4035-9f35-60771edcc3fc	6b4a7c02-4407-4290-8566-41dff1624c70
2418f642-0cfb-4548-9038-0a9ebe8f5134	6b4a7c02-4407-4290-8566-41dff1624c70
b9171e33-1819-4461-b62c-49c430b1eb2c	6b4a7c02-4407-4290-8566-41dff1624c70
ca8c3a4c-16e0-48ce-87cd-baf026000313	6b4a7c02-4407-4290-8566-41dff1624c70
cf75013e-e6b9-4550-b49c-7ba07c3f9b98	6b4a7c02-4407-4290-8566-41dff1624c70
0dd76cd0-a9e9-4864-af2d-61517b7b46ba	6b4a7c02-4407-4290-8566-41dff1624c70
f7cc1a4a-eabc-4836-a224-dd702c2775f3	6b4a7c02-4407-4290-8566-41dff1624c70
615e2136-041e-41e6-b80b-14419a4b5804	6b4a7c02-4407-4290-8566-41dff1624c70
5d872c94-dfe2-4f59-896b-eee9651f74b9	6b4a7c02-4407-4290-8566-41dff1624c70
f94f1feb-174b-4052-8d76-c7997ed9c894	6b4a7c02-4407-4290-8566-41dff1624c70
adf585b4-a559-42fd-bfda-657c8142f8c4	6b4a7c02-4407-4290-8566-41dff1624c70
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
bdb9f6b6-db26-459a-a8b8-c2997e622ac8	+
c899cad9-1b5a-43a3-a1b0-3e64ff25d8f1	/*
61ae9827-8300-4046-a78b-6fc1df466f66	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

