# import json
# from deepdiff import DeepDiff

# class JsonComparator:
#     """Robot Framework library for comparing job title JSON files"""
    
#     ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    
#     def compare_job_title_files(self, original_path, updated_path):
#         """Compare two JSON files and return differences"""
#         with open(original_path) as f:
#             original = json.load(f)
#         with open(updated_path) as f:
#             updated = json.load(f)
        
#         # Convert to dict with Job Title as key
#         original_dict = {item['Job Title']: item for item in original}
#         updated_dict = {item['Job Title']: item for item in updated}
        
#         # Find differences
#         added = [title for title in updated_dict if title not in original_dict]
#         removed = [title for title in original_dict if title not in updated_dict]
        
#         modified = {}
#         common_titles = set(original_dict) & set(updated_dict)
#         for title in common_titles:
#             diff = DeepDiff(original_dict[title], updated_dict[title], 
#                           ignore_order=True,
#                           exclude_paths=["root['actions']"])
#             if diff:
#                 modified[title] = diff
        
#         return {
#             "added": added,
#             "removed": removed,
#             "modified": modified
#         }


import json
from deepdiff import DeepDiff
from robot.api.deco import keyword

class JsonCompareLibrary:
    """Robot Framework library for comparing JSON files"""
    
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    
    @keyword
    def compare_job_title_files(self, original_path, updated_path):
        """Compare two job title JSON files and return differences
        
        Returns dictionary with:
        - added: List of added job titles
        - removed: List of removed job titles
        - modified: Dict of modified jobs with changes
        """
        with open(original_path, 'r', encoding='utf-8') as f:
            original = json.load(f)
        with open(updated_path, 'r', encoding='utf-8') as f:
            updated = json.load(f)
        
        # Convert to dict with Job Title as key
        original_dict = {item['Job Title']: item for item in original}
        updated_dict = {item['Job Title']: item for item in updated}
        
        # Find differences
        added = [title for title in updated_dict if title not in original_dict]
        removed = [title for title in original_dict if title not in updated_dict]
        
        modified = {}
        common_titles = set(original_dict) & set(updated_dict)
        for title in common_titles:
            diff = DeepDiff(original_dict[title], updated_dict[title], 
                          ignore_order=True,
                          exclude_paths=["root['actions']"])
            if diff:
                modified[title] = diff
        
        return {
            "added": added,
            "removed": removed,
            "modified": modified
        }