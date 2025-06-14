PHP_ARG_ENABLE(grpc, whether to enable grpc support,
[  --enable-grpc           Enable grpc support])

if test "$PHP_GRPC" != "no"; then
  dnl Write more examples of tests here...

  dnl # --with-grpc -> add include path
  PHP_ADD_INCLUDE(PHP_EXT_SRCDIR()/include)
  PHP_ADD_INCLUDE(PHP_EXT_SRCDIR()/src/core/ext/upb-gen)
  PHP_ADD_INCLUDE(PHP_EXT_SRCDIR()/src/core/ext/upbdefs-gen)
  PHP_ADD_INCLUDE(PHP_EXT_SRCDIR()/src/php/ext/grpc)
  PHP_ADD_INCLUDE(PHP_EXT_SRCDIR()/third_party/abseil-cpp)
  PHP_ADD_INCLUDE(PHP_EXT_SRCDIR()/third_party/address_sorting/include)
  PHP_ADD_INCLUDE(PHP_EXT_SRCDIR()/third_party/boringssl-with-bazel/src/include)
  PHP_ADD_INCLUDE(PHP_EXT_SRCDIR()/third_party/re2)
  PHP_ADD_INCLUDE(PHP_EXT_SRCDIR()/third_party/upb)
  PHP_ADD_INCLUDE(PHP_EXT_SRCDIR()/third_party/utf8_range)
  PHP_ADD_INCLUDE(PHP_EXT_SRCDIR()/third_party/xxhash)

  LIBS="-lpthread $LIBS"

  CFLAGS="-std=c11 -g -O2"
  CXXFLAGS="-std=c++14 -fno-exceptions -fno-rtti -g -O2"
  GRPC_SHARED_LIBADD="-lpthread $GRPC_SHARED_LIBADD"
  PHP_REQUIRE_CXX()
  PHP_ADD_LIBRARY(pthread)
  PHP_ADD_LIBRARY(dl,,GRPC_SHARED_LIBADD)
  PHP_ADD_LIBRARY(dl)

  case $host in
    *darwin*)
      PHP_ADD_LIBRARY(c++,1,GRPC_SHARED_LIBADD)
      ;;
    *)
      PHP_ADD_LIBRARY(stdc++,1,GRPC_SHARED_LIBADD)
      PHP_ADD_LIBRARY(rt,,GRPC_SHARED_LIBADD)
      PHP_ADD_LIBRARY(rt)
      ;;
  esac

  PHP_SUBST(GRPC_SHARED_LIBADD)

  PHP_NEW_EXTENSION(grpc,
    src/core/channelz/channel_trace.cc \
    src/core/channelz/channelz.cc \
    src/core/channelz/channelz_registry.cc \
    src/core/client_channel/backup_poller.cc \
    src/core/client_channel/client_channel.cc \
    src/core/client_channel/client_channel_factory.cc \
    src/core/client_channel/client_channel_filter.cc \
    src/core/client_channel/client_channel_plugin.cc \
    src/core/client_channel/client_channel_service_config.cc \
    src/core/client_channel/direct_channel.cc \
    src/core/client_channel/dynamic_filters.cc \
    src/core/client_channel/global_subchannel_pool.cc \
    src/core/client_channel/lb_metadata.cc \
    src/core/client_channel/load_balanced_call_destination.cc \
    src/core/client_channel/local_subchannel_pool.cc \
    src/core/client_channel/retry_filter.cc \
    src/core/client_channel/retry_filter_legacy_call_data.cc \
    src/core/client_channel/retry_service_config.cc \
    src/core/client_channel/retry_throttle.cc \
    src/core/client_channel/subchannel.cc \
    src/core/client_channel/subchannel_pool_interface.cc \
    src/core/client_channel/subchannel_stream_client.cc \
    src/core/ext/filters/backend_metrics/backend_metric_filter.cc \
    src/core/ext/filters/census/grpc_context.cc \
    src/core/ext/filters/channel_idle/idle_filter_state.cc \
    src/core/ext/filters/channel_idle/legacy_channel_idle_filter.cc \
    src/core/ext/filters/fault_injection/fault_injection_filter.cc \
    src/core/ext/filters/fault_injection/fault_injection_service_config_parser.cc \
    src/core/ext/filters/gcp_authentication/gcp_authentication_filter.cc \
    src/core/ext/filters/gcp_authentication/gcp_authentication_service_config_parser.cc \
    src/core/ext/filters/http/client/http_client_filter.cc \
    src/core/ext/filters/http/client_authority_filter.cc \
    src/core/ext/filters/http/http_filters_plugin.cc \
    src/core/ext/filters/http/message_compress/compression_filter.cc \
    src/core/ext/filters/http/server/http_server_filter.cc \
    src/core/ext/filters/message_size/message_size_filter.cc \
    src/core/ext/filters/rbac/rbac_filter.cc \
    src/core/ext/filters/rbac/rbac_service_config_parser.cc \
    src/core/ext/filters/stateful_session/stateful_session_filter.cc \
    src/core/ext/filters/stateful_session/stateful_session_service_config_parser.cc \
    src/core/ext/transport/chttp2/alpn/alpn.cc \
    src/core/ext/transport/chttp2/client/chttp2_connector.cc \
    src/core/ext/transport/chttp2/server/chttp2_server.cc \
    src/core/ext/transport/chttp2/transport/bin_decoder.cc \
    src/core/ext/transport/chttp2/transport/bin_encoder.cc \
    src/core/ext/transport/chttp2/transport/chttp2_transport.cc \
    src/core/ext/transport/chttp2/transport/decode_huff.cc \
    src/core/ext/transport/chttp2/transport/flow_control.cc \
    src/core/ext/transport/chttp2/transport/frame.cc \
    src/core/ext/transport/chttp2/transport/frame_data.cc \
    src/core/ext/transport/chttp2/transport/frame_goaway.cc \
    src/core/ext/transport/chttp2/transport/frame_ping.cc \
    src/core/ext/transport/chttp2/transport/frame_rst_stream.cc \
    src/core/ext/transport/chttp2/transport/frame_settings.cc \
    src/core/ext/transport/chttp2/transport/frame_window_update.cc \
    src/core/ext/transport/chttp2/transport/hpack_encoder.cc \
    src/core/ext/transport/chttp2/transport/hpack_encoder_table.cc \
    src/core/ext/transport/chttp2/transport/hpack_parse_result.cc \
    src/core/ext/transport/chttp2/transport/hpack_parser.cc \
    src/core/ext/transport/chttp2/transport/hpack_parser_table.cc \
    src/core/ext/transport/chttp2/transport/http2_settings.cc \
    src/core/ext/transport/chttp2/transport/huffsyms.cc \
    src/core/ext/transport/chttp2/transport/parsing.cc \
    src/core/ext/transport/chttp2/transport/ping_abuse_policy.cc \
    src/core/ext/transport/chttp2/transport/ping_callbacks.cc \
    src/core/ext/transport/chttp2/transport/ping_rate_policy.cc \
    src/core/ext/transport/chttp2/transport/stream_lists.cc \
    src/core/ext/transport/chttp2/transport/varint.cc \
    src/core/ext/transport/chttp2/transport/write_size_policy.cc \
    src/core/ext/transport/chttp2/transport/writing.cc \
    src/core/ext/transport/inproc/inproc_transport.cc \
    src/core/ext/transport/inproc/legacy_inproc_transport.cc \
    src/core/ext/upb-gen/envoy/admin/v3/certs.upb_minitable.c \
    src/core/ext/upb-gen/envoy/admin/v3/clusters.upb_minitable.c \
    src/core/ext/upb-gen/envoy/admin/v3/config_dump.upb_minitable.c \
    src/core/ext/upb-gen/envoy/admin/v3/config_dump_shared.upb_minitable.c \
    src/core/ext/upb-gen/envoy/admin/v3/init_dump.upb_minitable.c \
    src/core/ext/upb-gen/envoy/admin/v3/listeners.upb_minitable.c \
    src/core/ext/upb-gen/envoy/admin/v3/memory.upb_minitable.c \
    src/core/ext/upb-gen/envoy/admin/v3/metrics.upb_minitable.c \
    src/core/ext/upb-gen/envoy/admin/v3/mutex_stats.upb_minitable.c \
    src/core/ext/upb-gen/envoy/admin/v3/server_info.upb_minitable.c \
    src/core/ext/upb-gen/envoy/admin/v3/tap.upb_minitable.c \
    src/core/ext/upb-gen/envoy/annotations/deprecation.upb_minitable.c \
    src/core/ext/upb-gen/envoy/annotations/resource.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/accesslog/v3/accesslog.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/bootstrap/v3/bootstrap.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/cluster/v3/circuit_breaker.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/cluster/v3/cluster.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/cluster/v3/filter.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/cluster/v3/outlier_detection.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/common/matcher/v3/matcher.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/address.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/backoff.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/base.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/config_source.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/event_service_config.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/extension.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/grpc_method_list.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/grpc_service.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/health_check.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/http_service.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/http_uri.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/protocol.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/proxy_protocol.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/resolver.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/socket_option.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/substitution_format_string.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/core/v3/udp_socket_config.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/endpoint/v3/endpoint.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/endpoint/v3/endpoint_components.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/endpoint/v3/load_report.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/listener/v3/api_listener.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/listener/v3/listener.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/listener/v3/listener_components.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/listener/v3/quic_config.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/listener/v3/udp_listener_config.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/metrics/v3/metrics_service.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/metrics/v3/stats.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/overload/v3/overload.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/rbac/v3/rbac.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/route/v3/route.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/route/v3/route_components.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/route/v3/scoped_route.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/tap/v3/common.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/trace/v3/datadog.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/trace/v3/dynamic_ot.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/trace/v3/http_tracer.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/trace/v3/lightstep.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/trace/v3/opencensus.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/trace/v3/opentelemetry.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/trace/v3/service.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/trace/v3/skywalking.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/trace/v3/trace.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/trace/v3/xray.upb_minitable.c \
    src/core/ext/upb-gen/envoy/config/trace/v3/zipkin.upb_minitable.c \
    src/core/ext/upb-gen/envoy/data/accesslog/v3/accesslog.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/clusters/aggregate/v3/cluster.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/filters/common/fault/v3/fault.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/filters/http/fault/v3/fault.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/filters/http/gcp_authn/v3/gcp_authn.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/filters/http/rbac/v3/rbac.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/filters/http/router/v3/router.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/filters/http/stateful_session/v3/stateful_session.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/filters/network/http_connection_manager/v3/http_connection_manager.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/http/stateful_session/cookie/v3/cookie.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/load_balancing_policies/client_side_weighted_round_robin/v3/client_side_weighted_round_robin.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/load_balancing_policies/common/v3/common.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/load_balancing_policies/pick_first/v3/pick_first.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/load_balancing_policies/ring_hash/v3/ring_hash.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/load_balancing_policies/wrr_locality/v3/wrr_locality.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/transport_sockets/tls/v3/cert.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/transport_sockets/tls/v3/common.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/transport_sockets/tls/v3/secret.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/transport_sockets/tls/v3/tls.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/transport_sockets/tls/v3/tls_spiffe_validator_config.upb_minitable.c \
    src/core/ext/upb-gen/envoy/extensions/upstreams/http/v3/http_protocol_options.upb_minitable.c \
    src/core/ext/upb-gen/envoy/service/discovery/v3/ads.upb_minitable.c \
    src/core/ext/upb-gen/envoy/service/discovery/v3/discovery.upb_minitable.c \
    src/core/ext/upb-gen/envoy/service/load_stats/v3/lrs.upb_minitable.c \
    src/core/ext/upb-gen/envoy/service/status/v3/csds.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/http/v3/cookie.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/http/v3/path_transformation.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/matcher/v3/filter_state.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/matcher/v3/http_inputs.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/matcher/v3/metadata.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/matcher/v3/node.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/matcher/v3/number.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/matcher/v3/path.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/matcher/v3/regex.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/matcher/v3/status_code_input.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/matcher/v3/string.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/matcher/v3/struct.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/matcher/v3/value.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/metadata/v3/metadata.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/tracing/v3/custom_tag.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/v3/hash_policy.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/v3/http.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/v3/http_status.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/v3/percent.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/v3/range.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/v3/ratelimit_strategy.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/v3/ratelimit_unit.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/v3/semantic_version.upb_minitable.c \
    src/core/ext/upb-gen/envoy/type/v3/token_bucket.upb_minitable.c \
    src/core/ext/upb-gen/google/api/annotations.upb_minitable.c \
    src/core/ext/upb-gen/google/api/expr/v1alpha1/checked.upb_minitable.c \
    src/core/ext/upb-gen/google/api/expr/v1alpha1/syntax.upb_minitable.c \
    src/core/ext/upb-gen/google/api/http.upb_minitable.c \
    src/core/ext/upb-gen/google/api/httpbody.upb_minitable.c \
    src/core/ext/upb-gen/google/protobuf/any.upb_minitable.c \
    src/core/ext/upb-gen/google/protobuf/descriptor.upb_minitable.c \
    src/core/ext/upb-gen/google/protobuf/duration.upb_minitable.c \
    src/core/ext/upb-gen/google/protobuf/empty.upb_minitable.c \
    src/core/ext/upb-gen/google/protobuf/struct.upb_minitable.c \
    src/core/ext/upb-gen/google/protobuf/timestamp.upb_minitable.c \
    src/core/ext/upb-gen/google/protobuf/wrappers.upb_minitable.c \
    src/core/ext/upb-gen/google/rpc/status.upb_minitable.c \
    src/core/ext/upb-gen/opencensus/proto/trace/v1/trace_config.upb_minitable.c \
    src/core/ext/upb-gen/src/proto/grpc/gcp/altscontext.upb_minitable.c \
    src/core/ext/upb-gen/src/proto/grpc/gcp/handshaker.upb_minitable.c \
    src/core/ext/upb-gen/src/proto/grpc/gcp/transport_security_common.upb_minitable.c \
    src/core/ext/upb-gen/src/proto/grpc/health/v1/health.upb_minitable.c \
    src/core/ext/upb-gen/src/proto/grpc/lb/v1/load_balancer.upb_minitable.c \
    src/core/ext/upb-gen/src/proto/grpc/lookup/v1/rls.upb_minitable.c \
    src/core/ext/upb-gen/src/proto/grpc/lookup/v1/rls_config.upb_minitable.c \
    src/core/ext/upb-gen/udpa/annotations/migrate.upb_minitable.c \
    src/core/ext/upb-gen/udpa/annotations/security.upb_minitable.c \
    src/core/ext/upb-gen/udpa/annotations/sensitive.upb_minitable.c \
    src/core/ext/upb-gen/udpa/annotations/status.upb_minitable.c \
    src/core/ext/upb-gen/udpa/annotations/versioning.upb_minitable.c \
    src/core/ext/upb-gen/validate/validate.upb_minitable.c \
    src/core/ext/upb-gen/xds/annotations/v3/migrate.upb_minitable.c \
    src/core/ext/upb-gen/xds/annotations/v3/security.upb_minitable.c \
    src/core/ext/upb-gen/xds/annotations/v3/sensitive.upb_minitable.c \
    src/core/ext/upb-gen/xds/annotations/v3/status.upb_minitable.c \
    src/core/ext/upb-gen/xds/annotations/v3/versioning.upb_minitable.c \
    src/core/ext/upb-gen/xds/core/v3/authority.upb_minitable.c \
    src/core/ext/upb-gen/xds/core/v3/cidr.upb_minitable.c \
    src/core/ext/upb-gen/xds/core/v3/collection_entry.upb_minitable.c \
    src/core/ext/upb-gen/xds/core/v3/context_params.upb_minitable.c \
    src/core/ext/upb-gen/xds/core/v3/extension.upb_minitable.c \
    src/core/ext/upb-gen/xds/core/v3/resource.upb_minitable.c \
    src/core/ext/upb-gen/xds/core/v3/resource_locator.upb_minitable.c \
    src/core/ext/upb-gen/xds/core/v3/resource_name.upb_minitable.c \
    src/core/ext/upb-gen/xds/data/orca/v3/orca_load_report.upb_minitable.c \
    src/core/ext/upb-gen/xds/service/orca/v3/orca.upb_minitable.c \
    src/core/ext/upb-gen/xds/type/matcher/v3/cel.upb_minitable.c \
    src/core/ext/upb-gen/xds/type/matcher/v3/domain.upb_minitable.c \
    src/core/ext/upb-gen/xds/type/matcher/v3/http_inputs.upb_minitable.c \
    src/core/ext/upb-gen/xds/type/matcher/v3/ip.upb_minitable.c \
    src/core/ext/upb-gen/xds/type/matcher/v3/matcher.upb_minitable.c \
    src/core/ext/upb-gen/xds/type/matcher/v3/range.upb_minitable.c \
    src/core/ext/upb-gen/xds/type/matcher/v3/regex.upb_minitable.c \
    src/core/ext/upb-gen/xds/type/matcher/v3/string.upb_minitable.c \
    src/core/ext/upb-gen/xds/type/v3/cel.upb_minitable.c \
    src/core/ext/upb-gen/xds/type/v3/range.upb_minitable.c \
    src/core/ext/upb-gen/xds/type/v3/typed_struct.upb_minitable.c \
    src/core/ext/upbdefs-gen/envoy/admin/v3/certs.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/admin/v3/clusters.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/admin/v3/config_dump.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/admin/v3/config_dump_shared.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/admin/v3/init_dump.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/admin/v3/listeners.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/admin/v3/memory.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/admin/v3/metrics.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/admin/v3/mutex_stats.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/admin/v3/server_info.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/admin/v3/tap.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/annotations/deprecation.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/annotations/resource.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/accesslog/v3/accesslog.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/bootstrap/v3/bootstrap.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/cluster/v3/circuit_breaker.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/cluster/v3/cluster.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/cluster/v3/filter.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/cluster/v3/outlier_detection.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/common/matcher/v3/matcher.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/address.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/backoff.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/base.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/config_source.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/event_service_config.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/extension.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/grpc_method_list.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/grpc_service.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/health_check.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/http_service.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/http_uri.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/protocol.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/proxy_protocol.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/resolver.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/socket_option.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/substitution_format_string.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/core/v3/udp_socket_config.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/endpoint/v3/endpoint.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/endpoint/v3/endpoint_components.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/endpoint/v3/load_report.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/listener/v3/api_listener.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/listener/v3/listener.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/listener/v3/listener_components.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/listener/v3/quic_config.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/listener/v3/udp_listener_config.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/metrics/v3/metrics_service.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/metrics/v3/stats.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/overload/v3/overload.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/rbac/v3/rbac.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/route/v3/route.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/route/v3/route_components.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/route/v3/scoped_route.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/tap/v3/common.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/trace/v3/datadog.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/trace/v3/dynamic_ot.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/trace/v3/http_tracer.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/trace/v3/lightstep.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/trace/v3/opencensus.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/trace/v3/opentelemetry.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/trace/v3/service.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/trace/v3/skywalking.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/trace/v3/trace.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/trace/v3/xray.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/config/trace/v3/zipkin.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/data/accesslog/v3/accesslog.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/clusters/aggregate/v3/cluster.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/filters/common/fault/v3/fault.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/filters/http/fault/v3/fault.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/filters/http/gcp_authn/v3/gcp_authn.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/filters/http/rbac/v3/rbac.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/filters/http/router/v3/router.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/filters/http/stateful_session/v3/stateful_session.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/filters/network/http_connection_manager/v3/http_connection_manager.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/http/stateful_session/cookie/v3/cookie.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/transport_sockets/tls/v3/cert.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/transport_sockets/tls/v3/common.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/transport_sockets/tls/v3/secret.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/transport_sockets/tls/v3/tls.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/transport_sockets/tls/v3/tls_spiffe_validator_config.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/extensions/upstreams/http/v3/http_protocol_options.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/service/discovery/v3/ads.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/service/discovery/v3/discovery.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/service/load_stats/v3/lrs.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/service/status/v3/csds.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/http/v3/cookie.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/http/v3/path_transformation.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/matcher/v3/filter_state.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/matcher/v3/http_inputs.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/matcher/v3/metadata.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/matcher/v3/node.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/matcher/v3/number.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/matcher/v3/path.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/matcher/v3/regex.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/matcher/v3/status_code_input.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/matcher/v3/string.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/matcher/v3/struct.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/matcher/v3/value.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/metadata/v3/metadata.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/tracing/v3/custom_tag.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/v3/hash_policy.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/v3/http.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/v3/http_status.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/v3/percent.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/v3/range.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/v3/ratelimit_strategy.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/v3/ratelimit_unit.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/v3/semantic_version.upbdefs.c \
    src/core/ext/upbdefs-gen/envoy/type/v3/token_bucket.upbdefs.c \
    src/core/ext/upbdefs-gen/google/api/annotations.upbdefs.c \
    src/core/ext/upbdefs-gen/google/api/expr/v1alpha1/checked.upbdefs.c \
    src/core/ext/upbdefs-gen/google/api/expr/v1alpha1/syntax.upbdefs.c \
    src/core/ext/upbdefs-gen/google/api/http.upbdefs.c \
    src/core/ext/upbdefs-gen/google/api/httpbody.upbdefs.c \
    src/core/ext/upbdefs-gen/google/protobuf/any.upbdefs.c \
    src/core/ext/upbdefs-gen/google/protobuf/descriptor.upbdefs.c \
    src/core/ext/upbdefs-gen/google/protobuf/duration.upbdefs.c \
    src/core/ext/upbdefs-gen/google/protobuf/empty.upbdefs.c \
    src/core/ext/upbdefs-gen/google/protobuf/struct.upbdefs.c \
    src/core/ext/upbdefs-gen/google/protobuf/timestamp.upbdefs.c \
    src/core/ext/upbdefs-gen/google/protobuf/wrappers.upbdefs.c \
    src/core/ext/upbdefs-gen/google/rpc/status.upbdefs.c \
    src/core/ext/upbdefs-gen/opencensus/proto/trace/v1/trace_config.upbdefs.c \
    src/core/ext/upbdefs-gen/src/proto/grpc/lookup/v1/rls_config.upbdefs.c \
    src/core/ext/upbdefs-gen/udpa/annotations/migrate.upbdefs.c \
    src/core/ext/upbdefs-gen/udpa/annotations/security.upbdefs.c \
    src/core/ext/upbdefs-gen/udpa/annotations/sensitive.upbdefs.c \
    src/core/ext/upbdefs-gen/udpa/annotations/status.upbdefs.c \
    src/core/ext/upbdefs-gen/udpa/annotations/versioning.upbdefs.c \
    src/core/ext/upbdefs-gen/validate/validate.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/annotations/v3/migrate.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/annotations/v3/security.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/annotations/v3/sensitive.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/annotations/v3/status.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/annotations/v3/versioning.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/core/v3/authority.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/core/v3/cidr.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/core/v3/collection_entry.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/core/v3/context_params.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/core/v3/extension.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/core/v3/resource.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/core/v3/resource_locator.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/core/v3/resource_name.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/type/matcher/v3/cel.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/type/matcher/v3/domain.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/type/matcher/v3/http_inputs.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/type/matcher/v3/ip.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/type/matcher/v3/matcher.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/type/matcher/v3/range.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/type/matcher/v3/regex.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/type/matcher/v3/string.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/type/v3/cel.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/type/v3/range.upbdefs.c \
    src/core/ext/upbdefs-gen/xds/type/v3/typed_struct.upbdefs.c \
    src/core/handshaker/endpoint_info/endpoint_info_handshaker.cc \
    src/core/handshaker/handshaker.cc \
    src/core/handshaker/handshaker_registry.cc \
    src/core/handshaker/http_connect/http_connect_handshaker.cc \
    src/core/handshaker/http_connect/http_proxy_mapper.cc \
    src/core/handshaker/proxy_mapper_registry.cc \
    src/core/handshaker/security/secure_endpoint.cc \
    src/core/handshaker/security/security_handshaker.cc \
    src/core/handshaker/tcp_connect/tcp_connect_handshaker.cc \
    src/core/lib/address_utils/parse_address.cc \
    src/core/lib/address_utils/sockaddr_utils.cc \
    src/core/lib/backoff/backoff.cc \
    src/core/lib/backoff/random_early_detection.cc \
    src/core/lib/channel/channel_args.cc \
    src/core/lib/channel/channel_args_preconditioning.cc \
    src/core/lib/channel/channel_stack.cc \
    src/core/lib/channel/channel_stack_builder.cc \
    src/core/lib/channel/channel_stack_builder_impl.cc \
    src/core/lib/channel/connected_channel.cc \
    src/core/lib/channel/promise_based_filter.cc \
    src/core/lib/channel/status_util.cc \
    src/core/lib/compression/compression.cc \
    src/core/lib/compression/compression_internal.cc \
    src/core/lib/compression/message_compress.cc \
    src/core/lib/config/config_vars.cc \
    src/core/lib/config/config_vars_non_generated.cc \
    src/core/lib/config/core_configuration.cc \
    src/core/lib/config/load_config.cc \
    src/core/lib/debug/event_log.cc \
    src/core/lib/debug/trace.cc \
    src/core/lib/debug/trace_flags.cc \
    src/core/lib/event_engine/ares_resolver.cc \
    src/core/lib/event_engine/cf_engine/cf_engine.cc \
    src/core/lib/event_engine/cf_engine/cfstream_endpoint.cc \
    src/core/lib/event_engine/cf_engine/dns_service_resolver.cc \
    src/core/lib/event_engine/channel_args_endpoint_config.cc \
    src/core/lib/event_engine/default_event_engine.cc \
    src/core/lib/event_engine/default_event_engine_factory.cc \
    src/core/lib/event_engine/event_engine.cc \
    src/core/lib/event_engine/forkable.cc \
    src/core/lib/event_engine/posix_engine/ev_epoll1_linux.cc \
    src/core/lib/event_engine/posix_engine/ev_poll_posix.cc \
    src/core/lib/event_engine/posix_engine/event_poller_posix_default.cc \
    src/core/lib/event_engine/posix_engine/internal_errqueue.cc \
    src/core/lib/event_engine/posix_engine/lockfree_event.cc \
    src/core/lib/event_engine/posix_engine/native_posix_dns_resolver.cc \
    src/core/lib/event_engine/posix_engine/posix_endpoint.cc \
    src/core/lib/event_engine/posix_engine/posix_engine.cc \
    src/core/lib/event_engine/posix_engine/posix_engine_listener.cc \
    src/core/lib/event_engine/posix_engine/posix_engine_listener_utils.cc \
    src/core/lib/event_engine/posix_engine/tcp_socket_utils.cc \
    src/core/lib/event_engine/posix_engine/timer.cc \
    src/core/lib/event_engine/posix_engine/timer_heap.cc \
    src/core/lib/event_engine/posix_engine/timer_manager.cc \
    src/core/lib/event_engine/posix_engine/traced_buffer_list.cc \
    src/core/lib/event_engine/posix_engine/wakeup_fd_eventfd.cc \
    src/core/lib/event_engine/posix_engine/wakeup_fd_pipe.cc \
    src/core/lib/event_engine/posix_engine/wakeup_fd_posix_default.cc \
    src/core/lib/event_engine/resolved_address.cc \
    src/core/lib/event_engine/shim.cc \
    src/core/lib/event_engine/slice.cc \
    src/core/lib/event_engine/slice_buffer.cc \
    src/core/lib/event_engine/tcp_socket_utils.cc \
    src/core/lib/event_engine/thread_local.cc \
    src/core/lib/event_engine/thread_pool/thread_count.cc \
    src/core/lib/event_engine/thread_pool/thread_pool_factory.cc \
    src/core/lib/event_engine/thread_pool/work_stealing_thread_pool.cc \
    src/core/lib/event_engine/thready_event_engine/thready_event_engine.cc \
    src/core/lib/event_engine/time_util.cc \
    src/core/lib/event_engine/utils.cc \
    src/core/lib/event_engine/windows/grpc_polled_fd_windows.cc \
    src/core/lib/event_engine/windows/iocp.cc \
    src/core/lib/event_engine/windows/native_windows_dns_resolver.cc \
    src/core/lib/event_engine/windows/win_socket.cc \
    src/core/lib/event_engine/windows/windows_endpoint.cc \
    src/core/lib/event_engine/windows/windows_engine.cc \
    src/core/lib/event_engine/windows/windows_listener.cc \
    src/core/lib/event_engine/work_queue/basic_work_queue.cc \
    src/core/lib/experiments/config.cc \
    src/core/lib/experiments/experiments.cc \
    src/core/lib/gprpp/crash.cc \
    src/core/lib/gprpp/dump_args.cc \
    src/core/lib/gprpp/examine_stack.cc \
    src/core/lib/gprpp/fork.cc \
    src/core/lib/gprpp/glob.cc \
    src/core/lib/gprpp/host_port.cc \
    src/core/lib/gprpp/linux/env.cc \
    src/core/lib/gprpp/load_file.cc \
    src/core/lib/gprpp/mpscq.cc \
    src/core/lib/gprpp/per_cpu.cc \
    src/core/lib/gprpp/posix/directory_reader.cc \
    src/core/lib/gprpp/posix/env.cc \
    src/core/lib/gprpp/posix/stat.cc \
    src/core/lib/gprpp/posix/thd.cc \
    src/core/lib/gprpp/ref_counted_string.cc \
    src/core/lib/gprpp/status_helper.cc \
    src/core/lib/gprpp/strerror.cc \
    src/core/lib/gprpp/tchar.cc \
    src/core/lib/gprpp/time.cc \
    src/core/lib/gprpp/time_averaged_stats.cc \
    src/core/lib/gprpp/time_util.cc \
    src/core/lib/gprpp/uuid_v4.cc \
    src/core/lib/gprpp/validation_errors.cc \
    src/core/lib/gprpp/windows/directory_reader.cc \
    src/core/lib/gprpp/windows/env.cc \
    src/core/lib/gprpp/windows/stat.cc \
    src/core/lib/gprpp/windows/thd.cc \
    src/core/lib/gprpp/work_serializer.cc \
    src/core/lib/iomgr/buffer_list.cc \
    src/core/lib/iomgr/call_combiner.cc \
    src/core/lib/iomgr/cfstream_handle.cc \
    src/core/lib/iomgr/closure.cc \
    src/core/lib/iomgr/combiner.cc \
    src/core/lib/iomgr/dualstack_socket_posix.cc \
    src/core/lib/iomgr/endpoint.cc \
    src/core/lib/iomgr/endpoint_cfstream.cc \
    src/core/lib/iomgr/endpoint_pair_posix.cc \
    src/core/lib/iomgr/endpoint_pair_windows.cc \
    src/core/lib/iomgr/error.cc \
    src/core/lib/iomgr/error_cfstream.cc \
    src/core/lib/iomgr/ev_apple.cc \
    src/core/lib/iomgr/ev_epoll1_linux.cc \
    src/core/lib/iomgr/ev_poll_posix.cc \
    src/core/lib/iomgr/ev_posix.cc \
    src/core/lib/iomgr/event_engine_shims/closure.cc \
    src/core/lib/iomgr/event_engine_shims/endpoint.cc \
    src/core/lib/iomgr/event_engine_shims/tcp_client.cc \
    src/core/lib/iomgr/exec_ctx.cc \
    src/core/lib/iomgr/executor.cc \
    src/core/lib/iomgr/fork_posix.cc \
    src/core/lib/iomgr/fork_windows.cc \
    src/core/lib/iomgr/gethostname_fallback.cc \
    src/core/lib/iomgr/gethostname_host_name_max.cc \
    src/core/lib/iomgr/gethostname_sysconf.cc \
    src/core/lib/iomgr/grpc_if_nametoindex_posix.cc \
    src/core/lib/iomgr/grpc_if_nametoindex_unsupported.cc \
    src/core/lib/iomgr/internal_errqueue.cc \
    src/core/lib/iomgr/iocp_windows.cc \
    src/core/lib/iomgr/iomgr.cc \
    src/core/lib/iomgr/iomgr_internal.cc \
    src/core/lib/iomgr/iomgr_posix.cc \
    src/core/lib/iomgr/iomgr_posix_cfstream.cc \
    src/core/lib/iomgr/iomgr_windows.cc \
    src/core/lib/iomgr/lockfree_event.cc \
    src/core/lib/iomgr/polling_entity.cc \
    src/core/lib/iomgr/pollset.cc \
    src/core/lib/iomgr/pollset_set.cc \
    src/core/lib/iomgr/pollset_set_windows.cc \
    src/core/lib/iomgr/pollset_windows.cc \
    src/core/lib/iomgr/resolve_address.cc \
    src/core/lib/iomgr/resolve_address_posix.cc \
    src/core/lib/iomgr/resolve_address_windows.cc \
    src/core/lib/iomgr/sockaddr_utils_posix.cc \
    src/core/lib/iomgr/socket_factory_posix.cc \
    src/core/lib/iomgr/socket_mutator.cc \
    src/core/lib/iomgr/socket_utils_common_posix.cc \
    src/core/lib/iomgr/socket_utils_linux.cc \
    src/core/lib/iomgr/socket_utils_posix.cc \
    src/core/lib/iomgr/socket_utils_windows.cc \
    src/core/lib/iomgr/socket_windows.cc \
    src/core/lib/iomgr/systemd_utils.cc \
    src/core/lib/iomgr/tcp_client.cc \
    src/core/lib/iomgr/tcp_client_cfstream.cc \
    src/core/lib/iomgr/tcp_client_posix.cc \
    src/core/lib/iomgr/tcp_client_windows.cc \
    src/core/lib/iomgr/tcp_posix.cc \
    src/core/lib/iomgr/tcp_server.cc \
    src/core/lib/iomgr/tcp_server_posix.cc \
    src/core/lib/iomgr/tcp_server_utils_posix_common.cc \
    src/core/lib/iomgr/tcp_server_utils_posix_ifaddrs.cc \
    src/core/lib/iomgr/tcp_server_utils_posix_noifaddrs.cc \
    src/core/lib/iomgr/tcp_server_windows.cc \
    src/core/lib/iomgr/tcp_windows.cc \
    src/core/lib/iomgr/timer.cc \
    src/core/lib/iomgr/timer_generic.cc \
    src/core/lib/iomgr/timer_heap.cc \
    src/core/lib/iomgr/timer_manager.cc \
    src/core/lib/iomgr/unix_sockets_posix.cc \
    src/core/lib/iomgr/unix_sockets_posix_noop.cc \
    src/core/lib/iomgr/vsock.cc \
    src/core/lib/iomgr/wakeup_fd_eventfd.cc \
    src/core/lib/iomgr/wakeup_fd_nospecial.cc \
    src/core/lib/iomgr/wakeup_fd_pipe.cc \
    src/core/lib/iomgr/wakeup_fd_posix.cc \
    src/core/lib/matchers/matchers.cc \
    src/core/lib/promise/activity.cc \
    src/core/lib/promise/party.cc \
    src/core/lib/promise/sleep.cc \
    src/core/lib/resource_quota/api.cc \
    src/core/lib/resource_quota/arena.cc \
    src/core/lib/resource_quota/connection_quota.cc \
    src/core/lib/resource_quota/memory_quota.cc \
    src/core/lib/resource_quota/periodic_update.cc \
    src/core/lib/resource_quota/resource_quota.cc \
    src/core/lib/resource_quota/thread_quota.cc \
    src/core/lib/security/authorization/audit_logging.cc \
    src/core/lib/security/authorization/authorization_policy_provider_vtable.cc \
    src/core/lib/security/authorization/evaluate_args.cc \
    src/core/lib/security/authorization/grpc_authorization_engine.cc \
    src/core/lib/security/authorization/grpc_server_authz_filter.cc \
    src/core/lib/security/authorization/matchers.cc \
    src/core/lib/security/authorization/rbac_policy.cc \
    src/core/lib/security/authorization/stdout_logger.cc \
    src/core/lib/security/certificate_provider/certificate_provider_registry.cc \
    src/core/lib/security/context/security_context.cc \
    src/core/lib/security/credentials/alts/alts_credentials.cc \
    src/core/lib/security/credentials/alts/check_gcp_environment.cc \
    src/core/lib/security/credentials/alts/check_gcp_environment_linux.cc \
    src/core/lib/security/credentials/alts/check_gcp_environment_no_op.cc \
    src/core/lib/security/credentials/alts/check_gcp_environment_windows.cc \
    src/core/lib/security/credentials/alts/grpc_alts_credentials_client_options.cc \
    src/core/lib/security/credentials/alts/grpc_alts_credentials_options.cc \
    src/core/lib/security/credentials/alts/grpc_alts_credentials_server_options.cc \
    src/core/lib/security/credentials/call_creds_util.cc \
    src/core/lib/security/credentials/channel_creds_registry_init.cc \
    src/core/lib/security/credentials/composite/composite_credentials.cc \
    src/core/lib/security/credentials/credentials.cc \
    src/core/lib/security/credentials/external/aws_external_account_credentials.cc \
    src/core/lib/security/credentials/external/aws_request_signer.cc \
    src/core/lib/security/credentials/external/external_account_credentials.cc \
    src/core/lib/security/credentials/external/file_external_account_credentials.cc \
    src/core/lib/security/credentials/external/url_external_account_credentials.cc \
    src/core/lib/security/credentials/fake/fake_credentials.cc \
    src/core/lib/security/credentials/gcp_service_account_identity/gcp_service_account_identity_credentials.cc \
    src/core/lib/security/credentials/google_default/credentials_generic.cc \
    src/core/lib/security/credentials/google_default/google_default_credentials.cc \
    src/core/lib/security/credentials/iam/iam_credentials.cc \
    src/core/lib/security/credentials/insecure/insecure_credentials.cc \
    src/core/lib/security/credentials/jwt/json_token.cc \
    src/core/lib/security/credentials/jwt/jwt_credentials.cc \
    src/core/lib/security/credentials/jwt/jwt_verifier.cc \
    src/core/lib/security/credentials/local/local_credentials.cc \
    src/core/lib/security/credentials/oauth2/oauth2_credentials.cc \
    src/core/lib/security/credentials/plugin/plugin_credentials.cc \
    src/core/lib/security/credentials/ssl/ssl_credentials.cc \
    src/core/lib/security/credentials/tls/grpc_tls_certificate_distributor.cc \
    src/core/lib/security/credentials/tls/grpc_tls_certificate_match.cc \
    src/core/lib/security/credentials/tls/grpc_tls_certificate_provider.cc \
    src/core/lib/security/credentials/tls/grpc_tls_certificate_verifier.cc \
    src/core/lib/security/credentials/tls/grpc_tls_credentials_options.cc \
    src/core/lib/security/credentials/tls/grpc_tls_crl_provider.cc \
    src/core/lib/security/credentials/tls/tls_credentials.cc \
    src/core/lib/security/credentials/tls/tls_utils.cc \
    src/core/lib/security/credentials/token_fetcher/token_fetcher_credentials.cc \
    src/core/lib/security/credentials/xds/xds_credentials.cc \
    src/core/lib/security/security_connector/alts/alts_security_connector.cc \
    src/core/lib/security/security_connector/fake/fake_security_connector.cc \
    src/core/lib/security/security_connector/insecure/insecure_security_connector.cc \
    src/core/lib/security/security_connector/load_system_roots_fallback.cc \
    src/core/lib/security/security_connector/load_system_roots_supported.cc \
    src/core/lib/security/security_connector/load_system_roots_windows.cc \
    src/core/lib/security/security_connector/local/local_security_connector.cc \
    src/core/lib/security/security_connector/security_connector.cc \
    src/core/lib/security/security_connector/ssl/ssl_security_connector.cc \
    src/core/lib/security/security_connector/ssl_utils.cc \
    src/core/lib/security/security_connector/tls/tls_security_connector.cc \
    src/core/lib/security/transport/client_auth_filter.cc \
    src/core/lib/security/transport/server_auth_filter.cc \
    src/core/lib/security/util/json_util.cc \
    src/core/lib/slice/percent_encoding.cc \
    src/core/lib/slice/slice.cc \
    src/core/lib/slice/slice_buffer.cc \
    src/core/lib/slice/slice_string_helpers.cc \
    src/core/lib/surface/byte_buffer.cc \
    src/core/lib/surface/byte_buffer_reader.cc \
    src/core/lib/surface/call.cc \
    src/core/lib/surface/call_details.cc \
    src/core/lib/surface/call_log_batch.cc \
    src/core/lib/surface/call_utils.cc \
    src/core/lib/surface/channel.cc \
    src/core/lib/surface/channel_create.cc \
    src/core/lib/surface/channel_init.cc \
    src/core/lib/surface/channel_stack_type.cc \
    src/core/lib/surface/client_call.cc \
    src/core/lib/surface/completion_queue.cc \
    src/core/lib/surface/completion_queue_factory.cc \
    src/core/lib/surface/event_string.cc \
    src/core/lib/surface/filter_stack_call.cc \
    src/core/lib/surface/init.cc \
    src/core/lib/surface/init_internally.cc \
    src/core/lib/surface/lame_client.cc \
    src/core/lib/surface/legacy_channel.cc \
    src/core/lib/surface/metadata_array.cc \
    src/core/lib/surface/server_call.cc \
    src/core/lib/surface/validate_metadata.cc \
    src/core/lib/surface/version.cc \
    src/core/lib/transport/bdp_estimator.cc \
    src/core/lib/transport/call_arena_allocator.cc \
    src/core/lib/transport/call_filters.cc \
    src/core/lib/transport/call_final_info.cc \
    src/core/lib/transport/call_spine.cc \
    src/core/lib/transport/call_state.cc \
    src/core/lib/transport/connectivity_state.cc \
    src/core/lib/transport/error_utils.cc \
    src/core/lib/transport/interception_chain.cc \
    src/core/lib/transport/message.cc \
    src/core/lib/transport/metadata.cc \
    src/core/lib/transport/metadata_batch.cc \
    src/core/lib/transport/metadata_info.cc \
    src/core/lib/transport/parsed_metadata.cc \
    src/core/lib/transport/status_conversion.cc \
    src/core/lib/transport/timeout_encoding.cc \
    src/core/lib/transport/transport.cc \
    src/core/lib/transport/transport_op_string.cc \
    src/core/lib/uri/uri_parser.cc \
    src/core/load_balancing/address_filtering.cc \
    src/core/load_balancing/backend_metric_parser.cc \
    src/core/load_balancing/child_policy_handler.cc \
    src/core/load_balancing/endpoint_list.cc \
    src/core/load_balancing/grpclb/client_load_reporting_filter.cc \
    src/core/load_balancing/grpclb/grpclb.cc \
    src/core/load_balancing/grpclb/grpclb_balancer_addresses.cc \
    src/core/load_balancing/grpclb/grpclb_client_stats.cc \
    src/core/load_balancing/grpclb/load_balancer_api.cc \
    src/core/load_balancing/health_check_client.cc \
    src/core/load_balancing/lb_policy.cc \
    src/core/load_balancing/lb_policy_registry.cc \
    src/core/load_balancing/oob_backend_metric.cc \
    src/core/load_balancing/outlier_detection/outlier_detection.cc \
    src/core/load_balancing/pick_first/pick_first.cc \
    src/core/load_balancing/priority/priority.cc \
    src/core/load_balancing/ring_hash/ring_hash.cc \
    src/core/load_balancing/rls/rls.cc \
    src/core/load_balancing/round_robin/round_robin.cc \
    src/core/load_balancing/weighted_round_robin/static_stride_scheduler.cc \
    src/core/load_balancing/weighted_round_robin/weighted_round_robin.cc \
    src/core/load_balancing/weighted_target/weighted_target.cc \
    src/core/load_balancing/xds/cds.cc \
    src/core/load_balancing/xds/xds_cluster_impl.cc \
    src/core/load_balancing/xds/xds_cluster_manager.cc \
    src/core/load_balancing/xds/xds_override_host.cc \
    src/core/load_balancing/xds/xds_wrr_locality.cc \
    src/core/plugin_registry/grpc_plugin_registry.cc \
    src/core/plugin_registry/grpc_plugin_registry_extra.cc \
    src/core/resolver/binder/binder_resolver.cc \
    src/core/resolver/dns/c_ares/dns_resolver_ares.cc \
    src/core/resolver/dns/c_ares/grpc_ares_ev_driver_posix.cc \
    src/core/resolver/dns/c_ares/grpc_ares_ev_driver_windows.cc \
    src/core/resolver/dns/c_ares/grpc_ares_wrapper.cc \
    src/core/resolver/dns/c_ares/grpc_ares_wrapper_posix.cc \
    src/core/resolver/dns/c_ares/grpc_ares_wrapper_windows.cc \
    src/core/resolver/dns/dns_resolver_plugin.cc \
    src/core/resolver/dns/event_engine/event_engine_client_channel_resolver.cc \
    src/core/resolver/dns/event_engine/service_config_helper.cc \
    src/core/resolver/dns/native/dns_resolver.cc \
    src/core/resolver/endpoint_addresses.cc \
    src/core/resolver/fake/fake_resolver.cc \
    src/core/resolver/google_c2p/google_c2p_resolver.cc \
    src/core/resolver/polling_resolver.cc \
    src/core/resolver/resolver.cc \
    src/core/resolver/resolver_registry.cc \
    src/core/resolver/sockaddr/sockaddr_resolver.cc \
    src/core/resolver/xds/xds_config.cc \
    src/core/resolver/xds/xds_dependency_manager.cc \
    src/core/resolver/xds/xds_resolver.cc \
    src/core/server/server.cc \
    src/core/server/server_call_tracer_filter.cc \
    src/core/server/server_config_selector_filter.cc \
    src/core/server/xds_channel_stack_modifier.cc \
    src/core/server/xds_server_config_fetcher.cc \
    src/core/service_config/service_config_channel_arg_filter.cc \
    src/core/service_config/service_config_impl.cc \
    src/core/service_config/service_config_parser.cc \
    src/core/telemetry/call_tracer.cc \
    src/core/telemetry/histogram_view.cc \
    src/core/telemetry/metrics.cc \
    src/core/telemetry/stats.cc \
    src/core/telemetry/stats_data.cc \
    src/core/tsi/alts/crypt/aes_gcm.cc \
    src/core/tsi/alts/crypt/gsec.cc \
    src/core/tsi/alts/frame_protector/alts_counter.cc \
    src/core/tsi/alts/frame_protector/alts_crypter.cc \
    src/core/tsi/alts/frame_protector/alts_frame_protector.cc \
    src/core/tsi/alts/frame_protector/alts_record_protocol_crypter_common.cc \
    src/core/tsi/alts/frame_protector/alts_seal_privacy_integrity_crypter.cc \
    src/core/tsi/alts/frame_protector/alts_unseal_privacy_integrity_crypter.cc \
    src/core/tsi/alts/frame_protector/frame_handler.cc \
    src/core/tsi/alts/handshaker/alts_handshaker_client.cc \
    src/core/tsi/alts/handshaker/alts_shared_resource.cc \
    src/core/tsi/alts/handshaker/alts_tsi_handshaker.cc \
    src/core/tsi/alts/handshaker/alts_tsi_utils.cc \
    src/core/tsi/alts/handshaker/transport_security_common_api.cc \
    src/core/tsi/alts/zero_copy_frame_protector/alts_grpc_integrity_only_record_protocol.cc \
    src/core/tsi/alts/zero_copy_frame_protector/alts_grpc_privacy_integrity_record_protocol.cc \
    src/core/tsi/alts/zero_copy_frame_protector/alts_grpc_record_protocol_common.cc \
    src/core/tsi/alts/zero_copy_frame_protector/alts_iovec_record_protocol.cc \
    src/core/tsi/alts/zero_copy_frame_protector/alts_zero_copy_grpc_protector.cc \
    src/core/tsi/fake_transport_security.cc \
    src/core/tsi/local_transport_security.cc \
    src/core/tsi/ssl/key_logging/ssl_key_logging.cc \
    src/core/tsi/ssl/session_cache/ssl_session_boringssl.cc \
    src/core/tsi/ssl/session_cache/ssl_session_cache.cc \
    src/core/tsi/ssl/session_cache/ssl_session_openssl.cc \
    src/core/tsi/ssl_transport_security.cc \
    src/core/tsi/ssl_transport_security_utils.cc \
    src/core/tsi/transport_security.cc \
    src/core/tsi/transport_security_grpc.cc \
    src/core/util/alloc.cc \
    src/core/util/atm.cc \
    src/core/util/gcp_metadata_query.cc \
    src/core/util/http_client/format_request.cc \
    src/core/util/http_client/httpcli.cc \
    src/core/util/http_client/httpcli_security_connector.cc \
    src/core/util/http_client/parser.cc \
    src/core/util/iphone/cpu.cc \
    src/core/util/json/json_object_loader.cc \
    src/core/util/json/json_reader.cc \
    src/core/util/json/json_util.cc \
    src/core/util/json/json_writer.cc \
    src/core/util/latent_see.cc \
    src/core/util/linux/cpu.cc \
    src/core/util/log.cc \
    src/core/util/msys/tmpfile.cc \
    src/core/util/posix/cpu.cc \
    src/core/util/posix/string.cc \
    src/core/util/posix/sync.cc \
    src/core/util/posix/time.cc \
    src/core/util/posix/tmpfile.cc \
    src/core/util/string.cc \
    src/core/util/sync.cc \
    src/core/util/sync_abseil.cc \
    src/core/util/time.cc \
    src/core/util/time_precise.cc \
    src/core/util/windows/cpu.cc \
    src/core/util/windows/string.cc \
    src/core/util/windows/string_util.cc \
    src/core/util/windows/sync.cc \
    src/core/util/windows/time.cc \
    src/core/util/windows/tmpfile.cc \
    src/core/xds/grpc/certificate_provider_store.cc \
    src/core/xds/grpc/file_watcher_certificate_provider_factory.cc \
    src/core/xds/grpc/xds_audit_logger_registry.cc \
    src/core/xds/grpc/xds_bootstrap_grpc.cc \
    src/core/xds/grpc/xds_certificate_provider.cc \
    src/core/xds/grpc/xds_client_grpc.cc \
    src/core/xds/grpc/xds_cluster.cc \
    src/core/xds/grpc/xds_cluster_parser.cc \
    src/core/xds/grpc/xds_cluster_specifier_plugin.cc \
    src/core/xds/grpc/xds_common_types.cc \
    src/core/xds/grpc/xds_common_types_parser.cc \
    src/core/xds/grpc/xds_endpoint.cc \
    src/core/xds/grpc/xds_endpoint_parser.cc \
    src/core/xds/grpc/xds_health_status.cc \
    src/core/xds/grpc/xds_http_fault_filter.cc \
    src/core/xds/grpc/xds_http_filter_registry.cc \
    src/core/xds/grpc/xds_http_gcp_authn_filter.cc \
    src/core/xds/grpc/xds_http_rbac_filter.cc \
    src/core/xds/grpc/xds_http_stateful_session_filter.cc \
    src/core/xds/grpc/xds_lb_policy_registry.cc \
    src/core/xds/grpc/xds_listener.cc \
    src/core/xds/grpc/xds_listener_parser.cc \
    src/core/xds/grpc/xds_metadata.cc \
    src/core/xds/grpc/xds_metadata_parser.cc \
    src/core/xds/grpc/xds_route_config.cc \
    src/core/xds/grpc/xds_route_config_parser.cc \
    src/core/xds/grpc/xds_routing.cc \
    src/core/xds/grpc/xds_server_grpc.cc \
    src/core/xds/grpc/xds_transport_grpc.cc \
    src/core/xds/xds_client/xds_api.cc \
    src/core/xds/xds_client/xds_bootstrap.cc \
    src/core/xds/xds_client/xds_client.cc \
    src/core/xds/xds_client/xds_client_stats.cc \
    src/php/ext/grpc/byte_buffer.c \
    src/php/ext/grpc/call.c \
    src/php/ext/grpc/call_credentials.c \
    src/php/ext/grpc/channel.c \
    src/php/ext/grpc/channel_credentials.c \
    src/php/ext/grpc/completion_queue.c \
    src/php/ext/grpc/php_grpc.c \
    src/php/ext/grpc/server.c \
    src/php/ext/grpc/server_credentials.c \
    src/php/ext/grpc/timeval.c \
    third_party/abseil-cpp/absl/base/internal/cycleclock.cc \
    third_party/abseil-cpp/absl/base/internal/low_level_alloc.cc \
    third_party/abseil-cpp/absl/base/internal/raw_logging.cc \
    third_party/abseil-cpp/absl/base/internal/spinlock.cc \
    third_party/abseil-cpp/absl/base/internal/spinlock_wait.cc \
    third_party/abseil-cpp/absl/base/internal/strerror.cc \
    third_party/abseil-cpp/absl/base/internal/sysinfo.cc \
    third_party/abseil-cpp/absl/base/internal/thread_identity.cc \
    third_party/abseil-cpp/absl/base/internal/throw_delegate.cc \
    third_party/abseil-cpp/absl/base/internal/unscaledcycleclock.cc \
    third_party/abseil-cpp/absl/base/log_severity.cc \
    third_party/abseil-cpp/absl/container/internal/hashtablez_sampler.cc \
    third_party/abseil-cpp/absl/container/internal/hashtablez_sampler_force_weak_definition.cc \
    third_party/abseil-cpp/absl/container/internal/raw_hash_set.cc \
    third_party/abseil-cpp/absl/crc/crc32c.cc \
    third_party/abseil-cpp/absl/crc/internal/cpu_detect.cc \
    third_party/abseil-cpp/absl/crc/internal/crc.cc \
    third_party/abseil-cpp/absl/crc/internal/crc_cord_state.cc \
    third_party/abseil-cpp/absl/crc/internal/crc_memcpy_fallback.cc \
    third_party/abseil-cpp/absl/crc/internal/crc_memcpy_x86_arm_combined.cc \
    third_party/abseil-cpp/absl/crc/internal/crc_non_temporal_memcpy.cc \
    third_party/abseil-cpp/absl/crc/internal/crc_x86_arm_combined.cc \
    third_party/abseil-cpp/absl/debugging/internal/address_is_readable.cc \
    third_party/abseil-cpp/absl/debugging/internal/demangle.cc \
    third_party/abseil-cpp/absl/debugging/internal/elf_mem_image.cc \
    third_party/abseil-cpp/absl/debugging/internal/examine_stack.cc \
    third_party/abseil-cpp/absl/debugging/internal/vdso_support.cc \
    third_party/abseil-cpp/absl/debugging/stacktrace.cc \
    third_party/abseil-cpp/absl/debugging/symbolize.cc \
    third_party/abseil-cpp/absl/flags/commandlineflag.cc \
    third_party/abseil-cpp/absl/flags/internal/commandlineflag.cc \
    third_party/abseil-cpp/absl/flags/internal/flag.cc \
    third_party/abseil-cpp/absl/flags/internal/private_handle_accessor.cc \
    third_party/abseil-cpp/absl/flags/internal/program_name.cc \
    third_party/abseil-cpp/absl/flags/marshalling.cc \
    third_party/abseil-cpp/absl/flags/reflection.cc \
    third_party/abseil-cpp/absl/flags/usage_config.cc \
    third_party/abseil-cpp/absl/hash/internal/city.cc \
    third_party/abseil-cpp/absl/hash/internal/hash.cc \
    third_party/abseil-cpp/absl/hash/internal/low_level_hash.cc \
    third_party/abseil-cpp/absl/log/globals.cc \
    third_party/abseil-cpp/absl/log/internal/check_op.cc \
    third_party/abseil-cpp/absl/log/internal/conditions.cc \
    third_party/abseil-cpp/absl/log/internal/fnmatch.cc \
    third_party/abseil-cpp/absl/log/internal/globals.cc \
    third_party/abseil-cpp/absl/log/internal/log_format.cc \
    third_party/abseil-cpp/absl/log/internal/log_message.cc \
    third_party/abseil-cpp/absl/log/internal/log_sink_set.cc \
    third_party/abseil-cpp/absl/log/internal/nullguard.cc \
    third_party/abseil-cpp/absl/log/internal/proto.cc \
    third_party/abseil-cpp/absl/log/internal/vlog_config.cc \
    third_party/abseil-cpp/absl/log/log_entry.cc \
    third_party/abseil-cpp/absl/log/log_sink.cc \
    third_party/abseil-cpp/absl/numeric/int128.cc \
    third_party/abseil-cpp/absl/profiling/internal/exponential_biased.cc \
    third_party/abseil-cpp/absl/random/discrete_distribution.cc \
    third_party/abseil-cpp/absl/random/gaussian_distribution.cc \
    third_party/abseil-cpp/absl/random/internal/pool_urbg.cc \
    third_party/abseil-cpp/absl/random/internal/randen.cc \
    third_party/abseil-cpp/absl/random/internal/randen_detect.cc \
    third_party/abseil-cpp/absl/random/internal/randen_hwaes.cc \
    third_party/abseil-cpp/absl/random/internal/randen_round_keys.cc \
    third_party/abseil-cpp/absl/random/internal/randen_slow.cc \
    third_party/abseil-cpp/absl/random/internal/seed_material.cc \
    third_party/abseil-cpp/absl/random/seed_gen_exception.cc \
    third_party/abseil-cpp/absl/random/seed_sequences.cc \
    third_party/abseil-cpp/absl/status/internal/status_internal.cc \
    third_party/abseil-cpp/absl/status/status.cc \
    third_party/abseil-cpp/absl/status/status_payload_printer.cc \
    third_party/abseil-cpp/absl/status/statusor.cc \
    third_party/abseil-cpp/absl/strings/ascii.cc \
    third_party/abseil-cpp/absl/strings/charconv.cc \
    third_party/abseil-cpp/absl/strings/cord.cc \
    third_party/abseil-cpp/absl/strings/cord_analysis.cc \
    third_party/abseil-cpp/absl/strings/cord_buffer.cc \
    third_party/abseil-cpp/absl/strings/escaping.cc \
    third_party/abseil-cpp/absl/strings/internal/charconv_bigint.cc \
    third_party/abseil-cpp/absl/strings/internal/charconv_parse.cc \
    third_party/abseil-cpp/absl/strings/internal/cord_internal.cc \
    third_party/abseil-cpp/absl/strings/internal/cord_rep_btree.cc \
    third_party/abseil-cpp/absl/strings/internal/cord_rep_btree_navigator.cc \
    third_party/abseil-cpp/absl/strings/internal/cord_rep_btree_reader.cc \
    third_party/abseil-cpp/absl/strings/internal/cord_rep_consume.cc \
    third_party/abseil-cpp/absl/strings/internal/cord_rep_crc.cc \
    third_party/abseil-cpp/absl/strings/internal/cordz_functions.cc \
    third_party/abseil-cpp/absl/strings/internal/cordz_handle.cc \
    third_party/abseil-cpp/absl/strings/internal/cordz_info.cc \
    third_party/abseil-cpp/absl/strings/internal/damerau_levenshtein_distance.cc \
    third_party/abseil-cpp/absl/strings/internal/escaping.cc \
    third_party/abseil-cpp/absl/strings/internal/memutil.cc \
    third_party/abseil-cpp/absl/strings/internal/ostringstream.cc \
    third_party/abseil-cpp/absl/strings/internal/str_format/arg.cc \
    third_party/abseil-cpp/absl/strings/internal/str_format/bind.cc \
    third_party/abseil-cpp/absl/strings/internal/str_format/extension.cc \
    third_party/abseil-cpp/absl/strings/internal/str_format/float_conversion.cc \
    third_party/abseil-cpp/absl/strings/internal/str_format/output.cc \
    third_party/abseil-cpp/absl/strings/internal/str_format/parser.cc \
    third_party/abseil-cpp/absl/strings/internal/stringify_sink.cc \
    third_party/abseil-cpp/absl/strings/internal/utf8.cc \
    third_party/abseil-cpp/absl/strings/match.cc \
    third_party/abseil-cpp/absl/strings/numbers.cc \
    third_party/abseil-cpp/absl/strings/str_cat.cc \
    third_party/abseil-cpp/absl/strings/str_replace.cc \
    third_party/abseil-cpp/absl/strings/str_split.cc \
    third_party/abseil-cpp/absl/strings/string_view.cc \
    third_party/abseil-cpp/absl/strings/substitute.cc \
    third_party/abseil-cpp/absl/synchronization/barrier.cc \
    third_party/abseil-cpp/absl/synchronization/blocking_counter.cc \
    third_party/abseil-cpp/absl/synchronization/internal/create_thread_identity.cc \
    third_party/abseil-cpp/absl/synchronization/internal/futex_waiter.cc \
    third_party/abseil-cpp/absl/synchronization/internal/graphcycles.cc \
    third_party/abseil-cpp/absl/synchronization/internal/kernel_timeout.cc \
    third_party/abseil-cpp/absl/synchronization/internal/per_thread_sem.cc \
    third_party/abseil-cpp/absl/synchronization/internal/pthread_waiter.cc \
    third_party/abseil-cpp/absl/synchronization/internal/sem_waiter.cc \
    third_party/abseil-cpp/absl/synchronization/internal/stdcpp_waiter.cc \
    third_party/abseil-cpp/absl/synchronization/internal/waiter_base.cc \
    third_party/abseil-cpp/absl/synchronization/internal/win32_waiter.cc \
    third_party/abseil-cpp/absl/synchronization/mutex.cc \
    third_party/abseil-cpp/absl/synchronization/notification.cc \
    third_party/abseil-cpp/absl/time/civil_time.cc \
    third_party/abseil-cpp/absl/time/clock.cc \
    third_party/abseil-cpp/absl/time/duration.cc \
    third_party/abseil-cpp/absl/time/format.cc \
    third_party/abseil-cpp/absl/time/internal/cctz/src/civil_time_detail.cc \
    third_party/abseil-cpp/absl/time/internal/cctz/src/time_zone_fixed.cc \
    third_party/abseil-cpp/absl/time/internal/cctz/src/time_zone_format.cc \
    third_party/abseil-cpp/absl/time/internal/cctz/src/time_zone_if.cc \
    third_party/abseil-cpp/absl/time/internal/cctz/src/time_zone_impl.cc \
    third_party/abseil-cpp/absl/time/internal/cctz/src/time_zone_info.cc \
    third_party/abseil-cpp/absl/time/internal/cctz/src/time_zone_libc.cc \
    third_party/abseil-cpp/absl/time/internal/cctz/src/time_zone_lookup.cc \
    third_party/abseil-cpp/absl/time/internal/cctz/src/time_zone_posix.cc \
    third_party/abseil-cpp/absl/time/internal/cctz/src/zone_info_source.cc \
    third_party/abseil-cpp/absl/time/time.cc \
    third_party/abseil-cpp/absl/types/bad_optional_access.cc \
    third_party/abseil-cpp/absl/types/bad_variant_access.cc \
    third_party/address_sorting/address_sorting.c \
    third_party/address_sorting/address_sorting_posix.c \
    third_party/address_sorting/address_sorting_windows.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_bitstr.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_bool.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_d2i_fp.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_dup.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_gentm.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_i2d_fp.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_int.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_mbstr.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_object.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_octet.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_strex.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_strnid.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_time.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_type.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/a_utctm.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/asn1_lib.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/asn1_par.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/asn_pack.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/f_int.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/f_string.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/posix_time.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/tasn_dec.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/tasn_enc.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/tasn_fre.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/tasn_new.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/tasn_typ.c \
    third_party/boringssl-with-bazel/src/crypto/asn1/tasn_utl.c \
    third_party/boringssl-with-bazel/src/crypto/base64/base64.c \
    third_party/boringssl-with-bazel/src/crypto/bio/bio.c \
    third_party/boringssl-with-bazel/src/crypto/bio/bio_mem.c \
    third_party/boringssl-with-bazel/src/crypto/bio/connect.c \
    third_party/boringssl-with-bazel/src/crypto/bio/errno.c \
    third_party/boringssl-with-bazel/src/crypto/bio/fd.c \
    third_party/boringssl-with-bazel/src/crypto/bio/file.c \
    third_party/boringssl-with-bazel/src/crypto/bio/hexdump.c \
    third_party/boringssl-with-bazel/src/crypto/bio/pair.c \
    third_party/boringssl-with-bazel/src/crypto/bio/printf.c \
    third_party/boringssl-with-bazel/src/crypto/bio/socket.c \
    third_party/boringssl-with-bazel/src/crypto/bio/socket_helper.c \
    third_party/boringssl-with-bazel/src/crypto/blake2/blake2.c \
    third_party/boringssl-with-bazel/src/crypto/bn_extra/bn_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/bn_extra/convert.c \
    third_party/boringssl-with-bazel/src/crypto/buf/buf.c \
    third_party/boringssl-with-bazel/src/crypto/bytestring/asn1_compat.c \
    third_party/boringssl-with-bazel/src/crypto/bytestring/ber.c \
    third_party/boringssl-with-bazel/src/crypto/bytestring/cbb.c \
    third_party/boringssl-with-bazel/src/crypto/bytestring/cbs.c \
    third_party/boringssl-with-bazel/src/crypto/bytestring/unicode.c \
    third_party/boringssl-with-bazel/src/crypto/chacha/chacha.c \
    third_party/boringssl-with-bazel/src/crypto/cipher_extra/cipher_extra.c \
    third_party/boringssl-with-bazel/src/crypto/cipher_extra/derive_key.c \
    third_party/boringssl-with-bazel/src/crypto/cipher_extra/e_aesctrhmac.c \
    third_party/boringssl-with-bazel/src/crypto/cipher_extra/e_aesgcmsiv.c \
    third_party/boringssl-with-bazel/src/crypto/cipher_extra/e_chacha20poly1305.c \
    third_party/boringssl-with-bazel/src/crypto/cipher_extra/e_des.c \
    third_party/boringssl-with-bazel/src/crypto/cipher_extra/e_null.c \
    third_party/boringssl-with-bazel/src/crypto/cipher_extra/e_rc2.c \
    third_party/boringssl-with-bazel/src/crypto/cipher_extra/e_rc4.c \
    third_party/boringssl-with-bazel/src/crypto/cipher_extra/e_tls.c \
    third_party/boringssl-with-bazel/src/crypto/cipher_extra/tls_cbc.c \
    third_party/boringssl-with-bazel/src/crypto/conf/conf.c \
    third_party/boringssl-with-bazel/src/crypto/cpu_aarch64_apple.c \
    third_party/boringssl-with-bazel/src/crypto/cpu_aarch64_fuchsia.c \
    third_party/boringssl-with-bazel/src/crypto/cpu_aarch64_linux.c \
    third_party/boringssl-with-bazel/src/crypto/cpu_aarch64_openbsd.c \
    third_party/boringssl-with-bazel/src/crypto/cpu_aarch64_sysreg.c \
    third_party/boringssl-with-bazel/src/crypto/cpu_aarch64_win.c \
    third_party/boringssl-with-bazel/src/crypto/cpu_arm_freebsd.c \
    third_party/boringssl-with-bazel/src/crypto/cpu_arm_linux.c \
    third_party/boringssl-with-bazel/src/crypto/cpu_intel.c \
    third_party/boringssl-with-bazel/src/crypto/crypto.c \
    third_party/boringssl-with-bazel/src/crypto/curve25519/curve25519.c \
    third_party/boringssl-with-bazel/src/crypto/curve25519/curve25519_64_adx.c \
    third_party/boringssl-with-bazel/src/crypto/curve25519/spake25519.c \
    third_party/boringssl-with-bazel/src/crypto/des/des.c \
    third_party/boringssl-with-bazel/src/crypto/dh_extra/dh_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/dh_extra/params.c \
    third_party/boringssl-with-bazel/src/crypto/digest_extra/digest_extra.c \
    third_party/boringssl-with-bazel/src/crypto/dilithium/dilithium.c \
    third_party/boringssl-with-bazel/src/crypto/dsa/dsa.c \
    third_party/boringssl-with-bazel/src/crypto/dsa/dsa_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/ec_extra/ec_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/ec_extra/ec_derive.c \
    third_party/boringssl-with-bazel/src/crypto/ec_extra/hash_to_curve.c \
    third_party/boringssl-with-bazel/src/crypto/ecdh_extra/ecdh_extra.c \
    third_party/boringssl-with-bazel/src/crypto/ecdsa_extra/ecdsa_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/engine/engine.c \
    third_party/boringssl-with-bazel/src/crypto/err/err.c \
    third_party/boringssl-with-bazel/src/crypto/evp/evp.c \
    third_party/boringssl-with-bazel/src/crypto/evp/evp_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/evp/evp_ctx.c \
    third_party/boringssl-with-bazel/src/crypto/evp/p_dh.c \
    third_party/boringssl-with-bazel/src/crypto/evp/p_dh_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/evp/p_dsa_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/evp/p_ec.c \
    third_party/boringssl-with-bazel/src/crypto/evp/p_ec_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/evp/p_ed25519.c \
    third_party/boringssl-with-bazel/src/crypto/evp/p_ed25519_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/evp/p_hkdf.c \
    third_party/boringssl-with-bazel/src/crypto/evp/p_rsa.c \
    third_party/boringssl-with-bazel/src/crypto/evp/p_rsa_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/evp/p_x25519.c \
    third_party/boringssl-with-bazel/src/crypto/evp/p_x25519_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/evp/pbkdf.c \
    third_party/boringssl-with-bazel/src/crypto/evp/print.c \
    third_party/boringssl-with-bazel/src/crypto/evp/scrypt.c \
    third_party/boringssl-with-bazel/src/crypto/evp/sign.c \
    third_party/boringssl-with-bazel/src/crypto/ex_data.c \
    third_party/boringssl-with-bazel/src/crypto/fipsmodule/bcm.c \
    third_party/boringssl-with-bazel/src/crypto/fipsmodule/fips_shared_support.c \
    third_party/boringssl-with-bazel/src/crypto/hpke/hpke.c \
    third_party/boringssl-with-bazel/src/crypto/hrss/hrss.c \
    third_party/boringssl-with-bazel/src/crypto/keccak/keccak.c \
    third_party/boringssl-with-bazel/src/crypto/kyber/kyber.c \
    third_party/boringssl-with-bazel/src/crypto/lhash/lhash.c \
    third_party/boringssl-with-bazel/src/crypto/mem.c \
    third_party/boringssl-with-bazel/src/crypto/mldsa/mldsa.c \
    third_party/boringssl-with-bazel/src/crypto/mlkem/mlkem.cc \
    third_party/boringssl-with-bazel/src/crypto/obj/obj.c \
    third_party/boringssl-with-bazel/src/crypto/obj/obj_xref.c \
    third_party/boringssl-with-bazel/src/crypto/pem/pem_all.c \
    third_party/boringssl-with-bazel/src/crypto/pem/pem_info.c \
    third_party/boringssl-with-bazel/src/crypto/pem/pem_lib.c \
    third_party/boringssl-with-bazel/src/crypto/pem/pem_oth.c \
    third_party/boringssl-with-bazel/src/crypto/pem/pem_pk8.c \
    third_party/boringssl-with-bazel/src/crypto/pem/pem_pkey.c \
    third_party/boringssl-with-bazel/src/crypto/pem/pem_x509.c \
    third_party/boringssl-with-bazel/src/crypto/pem/pem_xaux.c \
    third_party/boringssl-with-bazel/src/crypto/pkcs7/pkcs7.c \
    third_party/boringssl-with-bazel/src/crypto/pkcs7/pkcs7_x509.c \
    third_party/boringssl-with-bazel/src/crypto/pkcs8/p5_pbev2.c \
    third_party/boringssl-with-bazel/src/crypto/pkcs8/pkcs8.c \
    third_party/boringssl-with-bazel/src/crypto/pkcs8/pkcs8_x509.c \
    third_party/boringssl-with-bazel/src/crypto/poly1305/poly1305.c \
    third_party/boringssl-with-bazel/src/crypto/poly1305/poly1305_arm.c \
    third_party/boringssl-with-bazel/src/crypto/poly1305/poly1305_vec.c \
    third_party/boringssl-with-bazel/src/crypto/pool/pool.c \
    third_party/boringssl-with-bazel/src/crypto/rand_extra/deterministic.c \
    third_party/boringssl-with-bazel/src/crypto/rand_extra/fork_detect.c \
    third_party/boringssl-with-bazel/src/crypto/rand_extra/forkunsafe.c \
    third_party/boringssl-with-bazel/src/crypto/rand_extra/getentropy.c \
    third_party/boringssl-with-bazel/src/crypto/rand_extra/ios.c \
    third_party/boringssl-with-bazel/src/crypto/rand_extra/passive.c \
    third_party/boringssl-with-bazel/src/crypto/rand_extra/rand_extra.c \
    third_party/boringssl-with-bazel/src/crypto/rand_extra/trusty.c \
    third_party/boringssl-with-bazel/src/crypto/rand_extra/urandom.c \
    third_party/boringssl-with-bazel/src/crypto/rand_extra/windows.c \
    third_party/boringssl-with-bazel/src/crypto/rc4/rc4.c \
    third_party/boringssl-with-bazel/src/crypto/refcount.c \
    third_party/boringssl-with-bazel/src/crypto/rsa_extra/rsa_asn1.c \
    third_party/boringssl-with-bazel/src/crypto/rsa_extra/rsa_crypt.c \
    third_party/boringssl-with-bazel/src/crypto/rsa_extra/rsa_print.c \
    third_party/boringssl-with-bazel/src/crypto/siphash/siphash.c \
    third_party/boringssl-with-bazel/src/crypto/spx/address.c \
    third_party/boringssl-with-bazel/src/crypto/spx/fors.c \
    third_party/boringssl-with-bazel/src/crypto/spx/merkle.c \
    third_party/boringssl-with-bazel/src/crypto/spx/spx.c \
    third_party/boringssl-with-bazel/src/crypto/spx/spx_util.c \
    third_party/boringssl-with-bazel/src/crypto/spx/thash.c \
    third_party/boringssl-with-bazel/src/crypto/spx/wots.c \
    third_party/boringssl-with-bazel/src/crypto/stack/stack.c \
    third_party/boringssl-with-bazel/src/crypto/thread.c \
    third_party/boringssl-with-bazel/src/crypto/thread_none.c \
    third_party/boringssl-with-bazel/src/crypto/thread_pthread.c \
    third_party/boringssl-with-bazel/src/crypto/thread_win.c \
    third_party/boringssl-with-bazel/src/crypto/trust_token/pmbtoken.c \
    third_party/boringssl-with-bazel/src/crypto/trust_token/trust_token.c \
    third_party/boringssl-with-bazel/src/crypto/trust_token/voprf.c \
    third_party/boringssl-with-bazel/src/crypto/x509/a_digest.c \
    third_party/boringssl-with-bazel/src/crypto/x509/a_sign.c \
    third_party/boringssl-with-bazel/src/crypto/x509/a_verify.c \
    third_party/boringssl-with-bazel/src/crypto/x509/algorithm.c \
    third_party/boringssl-with-bazel/src/crypto/x509/asn1_gen.c \
    third_party/boringssl-with-bazel/src/crypto/x509/by_dir.c \
    third_party/boringssl-with-bazel/src/crypto/x509/by_file.c \
    third_party/boringssl-with-bazel/src/crypto/x509/i2d_pr.c \
    third_party/boringssl-with-bazel/src/crypto/x509/name_print.c \
    third_party/boringssl-with-bazel/src/crypto/x509/policy.c \
    third_party/boringssl-with-bazel/src/crypto/x509/rsa_pss.c \
    third_party/boringssl-with-bazel/src/crypto/x509/t_crl.c \
    third_party/boringssl-with-bazel/src/crypto/x509/t_req.c \
    third_party/boringssl-with-bazel/src/crypto/x509/t_x509.c \
    third_party/boringssl-with-bazel/src/crypto/x509/t_x509a.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_akey.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_akeya.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_alt.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_bcons.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_bitst.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_conf.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_cpols.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_crld.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_enum.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_extku.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_genn.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_ia5.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_info.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_int.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_lib.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_ncons.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_ocsp.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_pcons.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_pmaps.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_prn.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_purp.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_skey.c \
    third_party/boringssl-with-bazel/src/crypto/x509/v3_utl.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_att.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_cmp.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_d2.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_def.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_ext.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_lu.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_obj.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_req.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_set.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_trs.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_txt.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_v3.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_vfy.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509_vpm.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509cset.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509name.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509rset.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x509spki.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_algor.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_all.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_attrib.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_crl.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_exten.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_name.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_pubkey.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_req.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_sig.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_spki.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_val.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_x509.c \
    third_party/boringssl-with-bazel/src/crypto/x509/x_x509a.c \
    third_party/boringssl-with-bazel/src/gen/crypto/err_data.c \
    third_party/boringssl-with-bazel/src/ssl/bio_ssl.cc \
    third_party/boringssl-with-bazel/src/ssl/d1_both.cc \
    third_party/boringssl-with-bazel/src/ssl/d1_lib.cc \
    third_party/boringssl-with-bazel/src/ssl/d1_pkt.cc \
    third_party/boringssl-with-bazel/src/ssl/d1_srtp.cc \
    third_party/boringssl-with-bazel/src/ssl/dtls_method.cc \
    third_party/boringssl-with-bazel/src/ssl/dtls_record.cc \
    third_party/boringssl-with-bazel/src/ssl/encrypted_client_hello.cc \
    third_party/boringssl-with-bazel/src/ssl/extensions.cc \
    third_party/boringssl-with-bazel/src/ssl/handoff.cc \
    third_party/boringssl-with-bazel/src/ssl/handshake.cc \
    third_party/boringssl-with-bazel/src/ssl/handshake_client.cc \
    third_party/boringssl-with-bazel/src/ssl/handshake_server.cc \
    third_party/boringssl-with-bazel/src/ssl/s3_both.cc \
    third_party/boringssl-with-bazel/src/ssl/s3_lib.cc \
    third_party/boringssl-with-bazel/src/ssl/s3_pkt.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_aead_ctx.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_asn1.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_buffer.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_cert.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_cipher.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_credential.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_file.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_key_share.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_lib.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_privkey.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_session.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_stat.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_transcript.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_versions.cc \
    third_party/boringssl-with-bazel/src/ssl/ssl_x509.cc \
    third_party/boringssl-with-bazel/src/ssl/t1_enc.cc \
    third_party/boringssl-with-bazel/src/ssl/tls13_both.cc \
    third_party/boringssl-with-bazel/src/ssl/tls13_client.cc \
    third_party/boringssl-with-bazel/src/ssl/tls13_enc.cc \
    third_party/boringssl-with-bazel/src/ssl/tls13_server.cc \
    third_party/boringssl-with-bazel/src/ssl/tls_method.cc \
    third_party/boringssl-with-bazel/src/ssl/tls_record.cc \
    third_party/re2/re2/bitstate.cc \
    third_party/re2/re2/compile.cc \
    third_party/re2/re2/dfa.cc \
    third_party/re2/re2/filtered_re2.cc \
    third_party/re2/re2/mimics_pcre.cc \
    third_party/re2/re2/nfa.cc \
    third_party/re2/re2/onepass.cc \
    third_party/re2/re2/parse.cc \
    third_party/re2/re2/perl_groups.cc \
    third_party/re2/re2/prefilter.cc \
    third_party/re2/re2/prefilter_tree.cc \
    third_party/re2/re2/prog.cc \
    third_party/re2/re2/re2.cc \
    third_party/re2/re2/regexp.cc \
    third_party/re2/re2/set.cc \
    third_party/re2/re2/simplify.cc \
    third_party/re2/re2/stringpiece.cc \
    third_party/re2/re2/tostring.cc \
    third_party/re2/re2/unicode_casefold.cc \
    third_party/re2/re2/unicode_groups.cc \
    third_party/re2/util/rune.cc \
    third_party/re2/util/strutil.cc \
    third_party/upb/upb/base/status.c \
    third_party/upb/upb/hash/common.c \
    third_party/upb/upb/json/decode.c \
    third_party/upb/upb/json/encode.c \
    third_party/upb/upb/lex/atoi.c \
    third_party/upb/upb/lex/round_trip.c \
    third_party/upb/upb/lex/strtod.c \
    third_party/upb/upb/lex/unicode.c \
    third_party/upb/upb/mem/alloc.c \
    third_party/upb/upb/mem/arena.c \
    third_party/upb/upb/message/accessors.c \
    third_party/upb/upb/message/array.c \
    third_party/upb/upb/message/compat.c \
    third_party/upb/upb/message/copy.c \
    third_party/upb/upb/message/internal/compare_unknown.c \
    third_party/upb/upb/message/internal/extension.c \
    third_party/upb/upb/message/internal/message.c \
    third_party/upb/upb/message/map.c \
    third_party/upb/upb/message/map_sorter.c \
    third_party/upb/upb/message/message.c \
    third_party/upb/upb/mini_descriptor/build_enum.c \
    third_party/upb/upb/mini_descriptor/decode.c \
    third_party/upb/upb/mini_descriptor/internal/base92.c \
    third_party/upb/upb/mini_descriptor/internal/encode.c \
    third_party/upb/upb/mini_descriptor/link.c \
    third_party/upb/upb/mini_table/extension_registry.c \
    third_party/upb/upb/mini_table/internal/message.c \
    third_party/upb/upb/mini_table/message.c \
    third_party/upb/upb/reflection/def_pool.c \
    third_party/upb/upb/reflection/def_type.c \
    third_party/upb/upb/reflection/desc_state.c \
    third_party/upb/upb/reflection/enum_def.c \
    third_party/upb/upb/reflection/enum_reserved_range.c \
    third_party/upb/upb/reflection/enum_value_def.c \
    third_party/upb/upb/reflection/extension_range.c \
    third_party/upb/upb/reflection/field_def.c \
    third_party/upb/upb/reflection/file_def.c \
    third_party/upb/upb/reflection/internal/def_builder.c \
    third_party/upb/upb/reflection/internal/strdup2.c \
    third_party/upb/upb/reflection/message.c \
    third_party/upb/upb/reflection/message_def.c \
    third_party/upb/upb/reflection/message_reserved_range.c \
    third_party/upb/upb/reflection/method_def.c \
    third_party/upb/upb/reflection/oneof_def.c \
    third_party/upb/upb/reflection/service_def.c \
    third_party/upb/upb/text/encode.c \
    third_party/upb/upb/wire/decode.c \
    third_party/upb/upb/wire/encode.c \
    third_party/upb/upb/wire/eps_copy_input_stream.c \
    third_party/upb/upb/wire/internal/decode_fast.c \
    third_party/upb/upb/wire/reader.c \
    third_party/utf8_range/utf8_range.c \
    , $ext_shared, , -fvisibility=hidden \
    -DOPENSSL_NO_ASM -D_GNU_SOURCE -DWIN32_LEAN_AND_MEAN \
    -D_HAS_EXCEPTIONS=0 -DNOMINMAX -DGRPC_ARES=0 \
    -DGRPC_POSIX_FORK_ALLOW_PTHREAD_ATFORK=1 \
    -DGRPC_XDS_USER_AGENT_NAME_SUFFIX='"\"PHP\""' \
    -DGRPC_XDS_USER_AGENT_VERSION_SUFFIX='"\"1.67.1\""')

  PHP_ADD_BUILD_DIR($ext_builddir/src/core/channelz)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/client_channel)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/filters/backend_metrics)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/filters/census)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/filters/channel_idle)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/filters/fault_injection)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/filters/gcp_authentication)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/filters/http)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/filters/http/client)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/filters/http/message_compress)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/filters/http/server)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/filters/message_size)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/filters/rbac)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/filters/stateful_session)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/transport/chttp2/alpn)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/transport/chttp2/client)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/transport/chttp2/server)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/transport/chttp2/transport)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/transport/inproc)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/admin/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/annotations)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/accesslog/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/bootstrap/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/cluster/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/common/matcher/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/core/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/endpoint/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/listener/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/metrics/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/overload/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/rbac/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/route/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/tap/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/config/trace/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/data/accesslog/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/clusters/aggregate/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/filters/common/fault/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/filters/http/fault/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/filters/http/gcp_authn/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/filters/http/rbac/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/filters/http/router/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/filters/http/stateful_session/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/filters/network/http_connection_manager/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/http/stateful_session/cookie/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/load_balancing_policies/client_side_weighted_round_robin/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/load_balancing_policies/common/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/load_balancing_policies/pick_first/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/load_balancing_policies/ring_hash/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/load_balancing_policies/wrr_locality/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/transport_sockets/tls/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/extensions/upstreams/http/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/service/discovery/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/service/load_stats/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/service/status/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/type/http/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/type/matcher/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/type/metadata/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/type/tracing/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/envoy/type/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/google/api)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/google/api/expr/v1alpha1)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/google/protobuf)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/google/rpc)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/opencensus/proto/trace/v1)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/src/proto/grpc/gcp)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/src/proto/grpc/health/v1)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/src/proto/grpc/lb/v1)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/src/proto/grpc/lookup/v1)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/udpa/annotations)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/validate)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/xds/annotations/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/xds/core/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/xds/data/orca/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/xds/service/orca/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/xds/type/matcher/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upb-gen/xds/type/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/admin/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/annotations)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/accesslog/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/bootstrap/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/cluster/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/common/matcher/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/core/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/endpoint/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/listener/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/metrics/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/overload/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/rbac/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/route/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/tap/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/config/trace/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/data/accesslog/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/extensions/clusters/aggregate/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/extensions/filters/common/fault/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/extensions/filters/http/fault/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/extensions/filters/http/gcp_authn/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/extensions/filters/http/rbac/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/extensions/filters/http/router/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/extensions/filters/http/stateful_session/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/extensions/filters/network/http_connection_manager/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/extensions/http/stateful_session/cookie/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/extensions/transport_sockets/tls/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/extensions/upstreams/http/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/service/discovery/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/service/load_stats/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/service/status/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/type/http/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/type/matcher/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/type/metadata/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/type/tracing/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/envoy/type/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/google/api)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/google/api/expr/v1alpha1)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/google/protobuf)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/google/rpc)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/opencensus/proto/trace/v1)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/src/proto/grpc/lookup/v1)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/udpa/annotations)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/validate)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/xds/annotations/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/xds/core/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/xds/type/matcher/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/ext/upbdefs-gen/xds/type/v3)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/handshaker)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/handshaker/endpoint_info)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/handshaker/http_connect)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/handshaker/security)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/handshaker/tcp_connect)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/address_utils)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/backoff)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/channel)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/compression)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/config)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/debug)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/event_engine)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/event_engine/cf_engine)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/event_engine/posix_engine)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/event_engine/thread_pool)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/event_engine/thready_event_engine)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/event_engine/windows)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/event_engine/work_queue)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/experiments)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/gprpp)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/gprpp/linux)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/gprpp/posix)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/gprpp/windows)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/iomgr)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/iomgr/event_engine_shims)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/matchers)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/promise)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/resource_quota)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/authorization)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/certificate_provider)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/context)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/alts)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/composite)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/external)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/fake)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/gcp_service_account_identity)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/google_default)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/iam)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/insecure)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/jwt)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/local)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/oauth2)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/plugin)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/ssl)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/tls)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/token_fetcher)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/credentials/xds)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/security_connector)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/security_connector/alts)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/security_connector/fake)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/security_connector/insecure)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/security_connector/local)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/security_connector/ssl)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/security_connector/tls)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/transport)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/security/util)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/slice)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/surface)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/transport)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/lib/uri)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/load_balancing)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/load_balancing/grpclb)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/load_balancing/outlier_detection)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/load_balancing/pick_first)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/load_balancing/priority)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/load_balancing/ring_hash)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/load_balancing/rls)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/load_balancing/round_robin)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/load_balancing/weighted_round_robin)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/load_balancing/weighted_target)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/load_balancing/xds)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/plugin_registry)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/resolver)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/resolver/binder)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/resolver/dns)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/resolver/dns/c_ares)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/resolver/dns/event_engine)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/resolver/dns/native)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/resolver/fake)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/resolver/google_c2p)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/resolver/sockaddr)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/resolver/xds)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/server)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/service_config)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/telemetry)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/tsi)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/tsi/alts/crypt)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/tsi/alts/frame_protector)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/tsi/alts/handshaker)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/tsi/alts/zero_copy_frame_protector)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/tsi/ssl/key_logging)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/tsi/ssl/session_cache)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/util)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/util/http_client)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/util/iphone)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/util/json)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/util/linux)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/util/msys)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/util/posix)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/util/windows)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/xds/grpc)
  PHP_ADD_BUILD_DIR($ext_builddir/src/core/xds/xds_client)
  PHP_ADD_BUILD_DIR($ext_builddir/src/php/ext/grpc)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/base)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/base/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/container/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/crc)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/crc/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/debugging)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/debugging/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/flags)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/flags/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/hash/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/log)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/log/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/numeric)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/profiling/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/random)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/random/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/status)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/status/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/strings)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/strings/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/strings/internal/str_format)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/synchronization)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/synchronization/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/time)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/time/internal/cctz/src)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/abseil-cpp/absl/types)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/address_sorting)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/asn1)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/base64)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/bio)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/blake2)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/bn_extra)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/buf)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/bytestring)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/chacha)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/cipher_extra)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/conf)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/curve25519)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/des)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/dh_extra)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/digest_extra)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/dilithium)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/dsa)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/ec_extra)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/ecdh_extra)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/ecdsa_extra)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/engine)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/err)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/evp)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/fipsmodule)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/hpke)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/hrss)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/keccak)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/kyber)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/lhash)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/mldsa)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/mlkem)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/obj)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/pem)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/pkcs7)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/pkcs8)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/poly1305)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/pool)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/rand_extra)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/rc4)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/rsa_extra)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/siphash)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/spx)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/stack)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/trust_token)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/crypto/x509)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/gen/crypto)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/boringssl-with-bazel/src/ssl)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/re2/re2)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/re2/util)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/base)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/hash)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/json)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/lex)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/mem)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/message)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/message/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/mini_descriptor)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/mini_descriptor/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/mini_table)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/mini_table/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/reflection)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/reflection/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/text)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/wire)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/upb/upb/wire/internal)
  PHP_ADD_BUILD_DIR($ext_builddir/third_party/utf8_range)
fi
