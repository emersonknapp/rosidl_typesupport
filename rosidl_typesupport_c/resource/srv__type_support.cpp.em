@# Included from rosidl_typesupport_c/resource/idl__type_support.c.em
@{
TEMPLATE(
    'msg__type_support.cpp.em',
    package_name=package_name, interface_path=interface_path,
    message=service.request_message, include_directives=include_directives,
    type_supports=type_supports)
}@

@{
TEMPLATE(
    'msg__type_support.cpp.em',
    package_name=package_name, interface_path=interface_path,
    message=service.response_message, include_directives=include_directives,
    type_supports=type_supports)
}@

@{
TEMPLATE(
    'msg__type_support.cpp.em',
    package_name=package_name, interface_path=interface_path,
    message=service.event_message, include_directives=include_directives,
    type_supports=type_supports)
}@

@{
from rosidl_pycommon import convert_camel_case_to_lower_case_underscore
include_parts = [package_name] + list(interface_path.parents[0].parts) + [
    'detail', convert_camel_case_to_lower_case_underscore(interface_path.stem)]
include_base = '/'.join(include_parts)

header_files = [
    'cstddef',
    'rosidl_runtime_c/service_type_support_struct.h',
    include_base + '__type_support.h',
]
if len(type_supports) != 1:
    header_files += [
        'rosidl_typesupport_c/identifier.h',
        'rosidl_typesupport_c/service_type_support_dispatch.h',
        'rosidl_typesupport_c/type_support_map.h',
    ]
header_files.append('rosidl_typesupport_interface/macros.h')
header_files.append('service_msgs/msg/service_event_info.h')
header_files.append('builtin_interfaces/msg/time.h')
}@
@[for header_file in header_files]@
@[    if header_file in include_directives]@
// already included above
// @
@[    else]@
@{include_directives.add(header_file)}@
@[    end if]@
#include "@(header_file)"
@[end for]@
@
@[if len(type_supports) != 1]@
@[  for ns in service.namespaced_type.namespaces]@

namespace @(ns)
{
@[  end for]@

namespace rosidl_typesupport_c
{
typedef struct _@(service.namespaced_type.name)_type_support_ids_t
{
  const char * typesupport_identifier[@(len(type_supports))];
} _@(service.namespaced_type.name)_type_support_ids_t;

static const _@(service.namespaced_type.name)_type_support_ids_t _@(service.namespaced_type.name)_service_typesupport_ids = {
  {
@# TODO(dirk-thomas) use identifier symbol again
@[for type_support in sorted(type_supports)]@
    "@(type_support)",  // ::@(type_support)::typesupport_identifier,
@[end for]@
  }
};

typedef struct _@(service.namespaced_type.name)_type_support_symbol_names_t
{
  const char * symbol_name[@(len(type_supports))];
} _@(service.namespaced_type.name)_type_support_symbol_names_t;

#define STRINGIFY_(s) #s
#define STRINGIFY(s) STRINGIFY_(s)

static const _@(service.namespaced_type.name)_type_support_symbol_names_t _@(service.namespaced_type.name)_service_typesupport_symbol_names = {
  {
@[for type_support in sorted(type_supports)]@
    STRINGIFY(ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(@(type_support), @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(service.namespaced_type.name))),
@[end for]@
  }
};

typedef struct _@(service.namespaced_type.name)_type_support_data_t
{
  void * data[@(len(type_supports))];
} _@(service.namespaced_type.name)_type_support_data_t;

static _@(service.namespaced_type.name)_type_support_data_t _@(service.namespaced_type.name)_service_typesupport_data = {
  {
@[for type_support in sorted(type_supports)]@
    0,  // will store the shared library later
@[end for]@
  }
};

static const type_support_map_t _@(service.namespaced_type.name)_service_typesupport_map = {
  @(len(type_supports)),
  "@(package_name)",
  &_@(service.namespaced_type.name)_service_typesupport_ids.typesupport_identifier[0],
  &_@(service.namespaced_type.name)_service_typesupport_symbol_names.symbol_name[0],
  &_@(service.namespaced_type.name)_service_typesupport_data.data[0],
};

static const rosidl_service_type_support_t @(service.namespaced_type.name)_service_type_support_handle = {
  rosidl_typesupport_c__typesupport_identifier,
  reinterpret_cast<const type_support_map_t *>(&_@(service.namespaced_type.name)_service_typesupport_map),
  rosidl_typesupport_c__get_service_typesupport_handle_function,
  ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_CREATE_EVENT_MESSAGE_SYMBOL_NAME(
    rosidl_typesupport_c,
    @(',\n    '.join(service.namespaced_type.namespaced_name()))
  ),
  ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_DESTROY_EVENT_MESSAGE_SYMBOL_NAME(
    rosidl_typesupport_c,
    @(',\n    '.join(service.namespaced_type.namespaced_name()))
  ),
  &@(service.namespaced_type.name)_Event_message_type_support_handle
};

}  // namespace rosidl_typesupport_c
@[  for ns in reversed(service.namespaced_type.namespaces)]@

}  // namespace @(ns)
@[  end for]@

@[else]@
@{
header_file = include_base + '__' + list(type_supports)[0] + '.h'
}@
@[  if header_file in include_directives]@
// already included above
// @
@[  else]@
@{include_directives.add(header_file)}@
@[  end if]@
#include "@(header_file)"

@[end if]@
#ifdef __cplusplus
extern "C"
{
#endif

const rosidl_service_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(rosidl_typesupport_c, @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(service.namespaced_type.name))() {
@[if len(type_supports) != 1]@
  return &::@('::'.join([package_name] + list(interface_path.parents[0].parts)))::rosidl_typesupport_c::@(service.namespaced_type.name)_service_type_support_handle;
@[else]@
  return ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(@(list(type_supports)[0]), @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(service.namespaced_type.name))();
@[end if]@
}

#ifdef __cplusplus
}
#endif
