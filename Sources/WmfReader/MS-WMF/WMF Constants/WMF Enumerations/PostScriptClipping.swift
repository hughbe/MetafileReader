//
//  PostScriptClipping.swift
//
//
//  Created by Hugh Bellamy on 02/12/2020.
//

/// [MS-WMF] 2.1.1.27 PostScriptClipping Enumeration
/// The PostScriptClipping Enumeration defines functions that can be applied to the clipping path used for PostScript output.
/// typedef enum
/// {
///  CLIP_SAVE = 0x0000,
///  CLIP_RESTORE = 0x0001,
///  CLIP_INCLUSIVE = 0x0002
/// } PostScriptClipping;
public enum PostScriptClipping: UInt16, DataStreamCreatable {
    /// CLIP_SAVE: Saves the current PostScript clipping path.
    case save = 0x0000
    
    /// CLIP_RESTORE: Restores the PostScript clipping path to the last clipping path that was saved by a previous CLIP_SAVE
    /// function applied by a CLIP_TO_PATH Record (section 2.3.6.6).
    case restore = 0x0001
    
    /// CLIP_INCLUSIVE: Intersects the current PostScript clipping path with the current clipping path and saves the result as the
    /// new PostScript clipping path.
    case inclusive = 0x0002
}
