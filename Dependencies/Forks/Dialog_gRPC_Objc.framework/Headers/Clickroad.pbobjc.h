// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: clickroad.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30004
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30004 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class GPBDoubleValue;
@class GPBStringValue;
@class GPBTimestamp;
@class TrackContext;
@class TrackError;
@class TrackEvent;
@class TrackMetric;
@class TrackScreenView;
@class TrackSocial;
@class TrackTiming;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ClickroadRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
GPB_FINAL @interface ClickroadRoot : GPBRootObject
@end

#pragma mark - TrackContext

typedef GPB_ENUM(TrackContext_FieldNumber) {
  TrackContext_FieldNumber_Context = 1,
};

GPB_FINAL @interface TrackContext : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableDictionary<NSString*, NSString*> *context;
/** The number of items in @c context without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger context_Count;

@end

#pragma mark - TrackScreenView

typedef GPB_ENUM(TrackScreenView_FieldNumber) {
  TrackScreenView_FieldNumber_Name = 1,
  TrackScreenView_FieldNumber_Source = 2,
  TrackScreenView_FieldNumber_URL = 3,
};

GPB_FINAL @interface TrackScreenView : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, strong, null_resettable) GPBStringValue *source;
/** Test to see if @c source has been set. */
@property(nonatomic, readwrite) BOOL hasSource;

@property(nonatomic, readwrite, strong, null_resettable) GPBStringValue *URL;
/** Test to see if @c URL has been set. */
@property(nonatomic, readwrite) BOOL hasURL;

@end

#pragma mark - TrackEvent

typedef GPB_ENUM(TrackEvent_FieldNumber) {
  TrackEvent_FieldNumber_Category = 1,
  TrackEvent_FieldNumber_Action = 2,
  TrackEvent_FieldNumber_Label = 3,
  TrackEvent_FieldNumber_Value = 4,
};

GPB_FINAL @interface TrackEvent : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *category;

@property(nonatomic, readwrite, copy, null_resettable) NSString *action;

@property(nonatomic, readwrite, strong, null_resettable) GPBStringValue *label;
/** Test to see if @c label has been set. */
@property(nonatomic, readwrite) BOOL hasLabel;

@property(nonatomic, readwrite, strong, null_resettable) GPBDoubleValue *value;
/** Test to see if @c value has been set. */
@property(nonatomic, readwrite) BOOL hasValue;

@end

#pragma mark - TrackTiming

typedef GPB_ENUM(TrackTiming_FieldNumber) {
  TrackTiming_FieldNumber_Category = 1,
  TrackTiming_FieldNumber_Variable = 2,
  TrackTiming_FieldNumber_Time = 3,
  TrackTiming_FieldNumber_Label = 4,
};

GPB_FINAL @interface TrackTiming : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *category;

@property(nonatomic, readwrite, copy, null_resettable) NSString *variable;

@property(nonatomic, readwrite) int64_t time;

@property(nonatomic, readwrite, strong, null_resettable) GPBStringValue *label;
/** Test to see if @c label has been set. */
@property(nonatomic, readwrite) BOOL hasLabel;

@end

#pragma mark - TrackSocial

typedef GPB_ENUM(TrackSocial_FieldNumber) {
  TrackSocial_FieldNumber_Network = 1,
  TrackSocial_FieldNumber_Action = 2,
  TrackSocial_FieldNumber_Target = 3,
};

GPB_FINAL @interface TrackSocial : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *network;

@property(nonatomic, readwrite, copy, null_resettable) NSString *action;

@property(nonatomic, readwrite, copy, null_resettable) NSString *target;

@end

#pragma mark - TrackError

typedef GPB_ENUM(TrackError_FieldNumber) {
  TrackError_FieldNumber_Message = 1,
  TrackError_FieldNumber_Fatal = 2,
};

GPB_FINAL @interface TrackError : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *message;

@property(nonatomic, readwrite) BOOL fatal;

@end

#pragma mark - TrackMetric

typedef GPB_ENUM(TrackMetric_FieldNumber) {
  TrackMetric_FieldNumber_Time = 1,
  TrackMetric_FieldNumber_Context = 2,
  TrackMetric_FieldNumber_ScreenView = 3,
  TrackMetric_FieldNumber_Event = 4,
  TrackMetric_FieldNumber_Timing = 5,
  TrackMetric_FieldNumber_Social = 6,
  TrackMetric_FieldNumber_Error = 7,
};

typedef GPB_ENUM(TrackMetric_Metric_OneOfCase) {
  TrackMetric_Metric_OneOfCase_GPBUnsetOneOfCase = 0,
  TrackMetric_Metric_OneOfCase_Context = 2,
  TrackMetric_Metric_OneOfCase_ScreenView = 3,
  TrackMetric_Metric_OneOfCase_Event = 4,
  TrackMetric_Metric_OneOfCase_Timing = 5,
  TrackMetric_Metric_OneOfCase_Social = 6,
  TrackMetric_Metric_OneOfCase_Error = 7,
};

GPB_FINAL @interface TrackMetric : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) GPBTimestamp *time;
/** Test to see if @c time has been set. */
@property(nonatomic, readwrite) BOOL hasTime;

@property(nonatomic, readonly) TrackMetric_Metric_OneOfCase metricOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) TrackContext *context;

@property(nonatomic, readwrite, strong, null_resettable) TrackScreenView *screenView;

@property(nonatomic, readwrite, strong, null_resettable) TrackEvent *event;

@property(nonatomic, readwrite, strong, null_resettable) TrackTiming *timing;

@property(nonatomic, readwrite, strong, null_resettable) TrackSocial *social;

@property(nonatomic, readwrite, strong, null_resettable) TrackError *error;

@end

/**
 * Clears whatever value was set for the oneof 'metric'.
 **/
void TrackMetric_ClearMetricOneOfCase(TrackMetric *message);

#pragma mark - RequestTrackEvent

typedef GPB_ENUM(RequestTrackEvent_FieldNumber) {
  RequestTrackEvent_FieldNumber_Cid = 1,
  RequestTrackEvent_FieldNumber_MetricsArray = 2,
};

GPB_FINAL @interface RequestTrackEvent : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *cid;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<TrackMetric*> *metricsArray;
/** The number of items in @c metricsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger metricsArray_Count;

@end

#pragma mark - ResponseTrackEvent

typedef GPB_ENUM(ResponseTrackEvent_FieldNumber) {
  ResponseTrackEvent_FieldNumber_Cid = 1,
};

GPB_FINAL @interface ResponseTrackEvent : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *cid;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
